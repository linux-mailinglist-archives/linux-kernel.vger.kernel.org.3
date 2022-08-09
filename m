Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958858DECA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiHISXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbiHISVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:21:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E424430F7D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tEZH78s39cZZpL1c4UpqCCA5GDPB6GsTZ8qHdrf+Wqo=;
        t=1660068480; x=1661278080; b=JHw8V9Q4vvO+nAPXJ+TfBtDOhPDUkqM8G5EMQcrfUb1abMD
        svioDSrNIDfPBguFOEuILma7gx0WtyLVv9kYlITu9HzYq0g8huLvUA5T3iaJPjFlS1G06faoUtjbJ
        f2YOY63WoD8QUK21xkglD9vEJhLiOdjKsofroJThGklmlIkMhvRp7XAGBKAqdFUavkcZSYdLep3ER
        0aiM4Y9xs6yt62IVSmKI37j5XrqPI8zlmemXaBYVHvavQ9dWp2e77pSSOZ9WShAmVrUBKmso0owlE
        6J8EF0KUdpJI7APOYGksKAYb9rUu40zT33EW9j1x5FmjEATkMq4Z9sYtERntvMCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oLTds-003HVP-2D;
        Tue, 09 Aug 2022 20:07:48 +0200
Message-ID: <76b5db88b280cccb784209b26fe48799dcb41b13.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: read multiple msg from virtio slave request fd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Aug 2022 20:07:47 +0200
In-Reply-To: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de>
References: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-06-07 at 11:27 +0000, Benjamin Beichler wrote:
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
>=20
> Anyways, in general it seems to be more natural to consume always all
> messages from a socket, instead of only a single one.
>=20
> Fixes: 2cd097ba8c05 ("um: virtio: Implement VHOST_USER_PROTOCOL_F_SLAVE_R=
EQ")
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
>=20

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>


Sorry, should've sent that earlier.

johannes
