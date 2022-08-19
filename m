Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F359A7ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiHSVnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Aug 2022 17:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiHSVnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53961B7CE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:43:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-47-4RE9sXC-OQ6fYpbHD6dEYg-1; Fri, 19 Aug 2022 22:43:43 +0100
X-MC-Unique: 4RE9sXC-OQ6fYpbHD6dEYg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Fri, 19 Aug 2022 22:43:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Fri, 19 Aug 2022 22:43:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hamza Mahfooz' <hamza.mahfooz@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        =?iso-8859-1?Q?Ma=EDra_Canal?= <mairacanal@riseup.net>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>,
        Bing Guo <Bing.Guo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix i386 frame size warning
Thread-Topic: [PATCH] drm/amd/display: fix i386 frame size warning
Thread-Index: AQHYsyK3bLhoYPUGX0aEEgc6M/SYOq22wp5Q
Date:   Fri, 19 Aug 2022 21:43:42 +0000
Message-ID: <f9f6fa60ae8c4e949ef9cce5b47f95bd@AcuMS.aculab.com>
References: <20220818164848.68729-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220818164848.68729-1-hamza.mahfooz@amd.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamza Mahfooz
> Sent: 18 August 2022 17:49
> 
> Addresses the following warning:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3596:6: error: stack frame
> size (2092) exceeds limit (2048) in 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-
> larger-than]
> void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>      ^
> 
> UseMinimumDCFCLK() is eating away at
> dml30_ModeSupportAndSystemConfigurationFull()'s stack space, so use a
> pointer to struct vba_vars_st instead of passing lots of large arrays
> as parameters by value.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  .../dc/dml/dcn30/display_mode_vba_30.c        | 295 ++++--------------
>  1 file changed, 63 insertions(+), 232 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 876b321b30ca..b7fa003ffe06 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -396,64 +396,10 @@ static void CalculateUrgentBurstFactor(
> 
>  static void UseMinimumDCFCLK(
>  		struct display_mode_lib *mode_lib,
> -		int MaxInterDCNTileRepeaters,
> +		struct vba_vars_st *v,

You should probably add 'const' in there.
Thinks will likely break if v->xxx gets changed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

