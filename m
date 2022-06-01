Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56453AB99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355583AbiFARNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiFARNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:13:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912FFA309C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Vhsrz++zOScPCObhONnyXrr24xL7G/28VsUqFD0yOzA=;
        t=1654103623; x=1655313223; b=qk3nfQDqK053MwUb7E5Edl8sdNPpqkfyB8Fva9XvU20lTqI
        gtOPH1crjldg6MIp1C/lQrIFh/c6fegWL+iG/KaCwW+vNaFlXcqpuflusDYOa9nE8o20kbyXQeY2T
        QIwPeml5oaGYiLEPgDDNYyxG9ZrjFHML7rVE4FQ9ykhOzi/tGh3OqsjcXF0M112llEXfL47NQyY25
        Aq0xBgS6LxZVP+t03DjNzodyJ8WhH7xKq2kliZ0AfIPe7BKzjWCGB1QiIQJvcPX/LG3bDIzgbu0Im
        QZ9dWbwd50pFZ0TTpI/FlFSdvi3TpZsUVvmoy+tcpzZOrzy/s9/Z0jCVCc9781EA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwRuU-00AUqk-6W;
        Wed, 01 Jun 2022 19:13:30 +0200
Message-ID: <360edf352f888f4607e0411df8a994aa087e9db4.camel@sipsolutions.net>
Subject: Re: [PATCH] um: read multiple msg from virtio slave request fd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jun 2022 19:13:29 +0200
In-Reply-To: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
References: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-01 at 15:37 +0000, Benjamin Beichler wrote:
> If VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is activated, the user mode
> linux virtio irq handler only read one msg from the corresponding socket.
> This creates issues, when the device emulation creates multiple call
> requests (e.g. for multiple virtqueues), as the socket buffer tend to fil=
l
> up and the call requests are delayed.
>=20
> This creates a deadlock situation, when the device simulation blocks,
> because of sending a msg and the kernel side blocks because of
> synchronously waiting for an acknowledge of kick request.
>=20
> Actually inband notifications are meant to be used in combination with th=
e
> time travel protocol, but it is not required, therefore this corner case
> needs to be handled.

Hmm. How did you run into this? Why would a device send many messages
and not wait for ACK, but the kernel side actually waits for ACK? What
would the use case for that be? Seems a bit odd, if both wait for ACK
there shouldn't be an issue?

Anyway, I guess I don't mind fixing this regardless of whether I see a
use case where it could happen :-)


> +++ b/arch/um/drivers/virtio_uml.c
> @@ -363,45 +363,47 @@ static irqreturn_t vu_req_read_message(struct virti=
o_uml_device *vu_dev,
>  		struct vhost_user_msg msg;
>  		u8 extra_payload[512];
>  	} msg;
> -	int rc;
> -
> -	rc =3D vhost_user_recv_req(vu_dev, &msg.msg,
> -				 sizeof(msg.msg.payload) +
> -				 sizeof(msg.extra_payload));
> -
> -	if (rc)

This code changed a bit, you should rebase onto the uml tree's for-next
branch.

> +	while (1) {
> +		if (vhost_user_recv_req(vu_dev, &msg.msg,
> +					sizeof(msg.msg.payload)
> +					+ sizeof(msg.extra_payload)))

prefer to keep the + on the previous line.


That said, my attempt at rebasing this made it all fail completely,
maybe you have better luck :)

johannes
