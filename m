Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB84C587E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiBZWWl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Feb 2022 17:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBZWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:22:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF6131ED4F4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:22:03 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-218-qo9exv-6NkuKleZpLM9g_w-1; Sat, 26 Feb 2022 22:22:00 +0000
X-MC-Unique: qo9exv-6NkuKleZpLM9g_w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sat, 26 Feb 2022 22:21:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sat, 26 Feb 2022 22:21:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'trix@redhat.com'" <trix@redhat.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nirmoy.das@amd.com" <nirmoy.das@amd.com>,
        "lijo.lazar@amd.com" <lijo.lazar@amd.com>,
        "tom.stdenis@amd.com" <tom.stdenis@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "kevin1.wang@amd.com" <kevin1.wang@amd.com>,
        "Amaranath.Somalapuram@amd.com" <Amaranath.Somalapuram@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] drm/amdgpu: Fix realloc of ptr
Thread-Topic: [PATCH] drm/amdgpu: Fix realloc of ptr
Thread-Index: AQHYKynKuecV+YVBsEaifDyg6Kuo9qymZ9yQ
Date:   Sat, 26 Feb 2022 22:21:58 +0000
Message-ID: <f863c19ccba34e50802836bcb3b0b622@AcuMS.aculab.com>
References: <20220226155851.4176109-1-trix@redhat.com>
In-Reply-To: <20220226155851.4176109-1-trix@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: trix@redhat.com
> Sent: 26 February 2022 15:59
> 
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this error
> amdgpu_debugfs.c:1690:9: warning: 1st function call
>   argument is an uninitialized value
>   tmp = krealloc_array(tmp, i + 1,
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> realloc will free tmp, so tmp can not be garbage.
> And the return needs to be checked.

Are you sure?
A quick check seems to show that krealloc() behaves the same
way as libc realloc() and the pointer isn't freed on failure.

	David

> Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 9eb9b440bd438..159b97c0b4ebc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>  	char reg_offset[11];
> -	uint32_t *tmp;
> +	uint32_t *tmp = NULL;
>  	int ret, i = 0, len = 0;
> 
>  	do {
> @@ -1688,6 +1688,10 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>  		}
> 
>  		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> +		if (!tmp) {
> +			ret = -ENOMEM;
> +			goto error_free;
> +		}
>  		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
>  			ret = -EINVAL;
>  			goto error_free;
> --
> 2.26.3

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

