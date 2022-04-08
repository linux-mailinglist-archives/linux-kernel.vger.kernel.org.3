Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C64F8E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiDHFqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiDHFqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BD381115A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649396686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECU0ZzpjTJbsqM/06UoyAixb0uPdjMhcy626dlK3x2E=;
        b=bz7FeliUPUe4kgyyYvcGVdeT0ccw3b8xLaWco+7Vocq2ecfBFQQ28lgRMNoKl3K1knl6U3
        ZBgzP29tKxtrOeMdICbYbsYmO1H+otfV5dHJbkqmFRTjQLsJVW9Hf4Ei86TY6SsbDlwXC4
        f38d5fDBLFmCtVkISVXwWmit7PcdlPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-C99I_CuvODqQgjWAZRPPNg-1; Fri, 08 Apr 2022 01:44:39 -0400
X-MC-Unique: C99I_CuvODqQgjWAZRPPNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CDDF80159B;
        Fri,  8 Apr 2022 05:44:33 +0000 (UTC)
Received: from maya.cloud.tilaa.com (unknown [10.40.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 912AC401475;
        Fri,  8 Apr 2022 05:44:30 +0000 (UTC)
Date:   Fri, 8 Apr 2022 07:44:24 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaehee Park <jhpark1013@gmail.com>
Cc:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <20220408074424.6e862f3f@elisabeth>
In-Reply-To: <Yk++AMDTu7LCbjHu@kroah.com>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
        <Yk++AMDTu7LCbjHu@kroah.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Fri, 8 Apr 2022 06:45:52 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 07, 2022 at 11:23:49PM -0400, Jaehee Park wrote:
> >
> > [...]
> >
> > @@ -61,7 +63,6 @@ struct wfx_dev {
> > =20
> >  struct wfx_vif {
> >  	struct wfx_dev             *wdev;
> > -	struct ieee80211_vif       *vif; =20
>=20
> You need to test this on real hardware.  For an outreachy-first-task,
> this is not a good one at all.

We discussed about this on the outreachy list, and I suggested, as
Jaehee also mentioned, that maybe somebody (J=C3=A9r=C3=B4me?) with the har=
dware
could give it a try.

It looks a bit difficult but it also looks almost correctly done now. :)

> Also this code is no longer in drivers/staging/  Please work on the
> netdev mailing list as I can not take these changes anymore.

Yeah, missed by a couple of days...

Jaehee, the list is actually linux-wireless for this one:
	https://wireless.wiki.kernel.org/en/developers/mailinglists

And the tree (my bad for mentioning net-next earlier) is actually
wireless-next:
	https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/

--=20
Stefano

