Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67F4B8C21
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiBPPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:12:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiBPPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:11:59 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 07:11:46 PST
Received: from smtp97.iad3b.emailsrvr.com (smtp97.iad3b.emailsrvr.com [146.20.161.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268A2AE07;
        Wed, 16 Feb 2022 07:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1645023828;
        bh=F0I1g8Iodxs1TYYZfhyaZMhWxcIOGrZzwTJS2frSzlM=;
        h=Date:Subject:To:From:From;
        b=h++3Om8rBhbI8ndeetZ+++N3SJPManU2ui6H2e+ipO6IqZyH5SsxrEtxJnU3sD+/M
         cKDVCemBkY5ikgP3+My0iLOXlGWxYiXgRwqndS/6A1InO65cPVXaYg0L3mGHm+137J
         XR+/3p8aU9/knd8xVMad9t8ceGIR8c6jgdIVyNhI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp5.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B4D24400A5;
        Wed, 16 Feb 2022 10:03:46 -0500 (EST)
Message-ID: <c8328ab5-7ea2-b9ba-fa71-9f2348729ea8@mev.co.uk>
Date:   Wed, 16 Feb 2022 15:03:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] comedi: drivers: ni_routes: Use strcmp() instead of
 memcmp()
Content-Language: en-GB
To:     Kees Cook <keescook@chromium.org>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Spencer E . Olson" <olsonse@umich.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20220215171017.1247291-1-keescook@chromium.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220215171017.1247291-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: c69dd1e8-1590-4aa0-802d-b75f2af30825-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 17:10, Kees Cook wrote:
> The family and device comparisons were using memcmp(), but this could
> lead to Out-of-bounds reads when the length was larger than the
> buffers being compared. Since these appear to always be NUL-terminated
> strings, just use strcmp() instead.
> 
> This was found with Clang under LTO:
> 
> [ 92.405851][    T1] kernel BUG at lib/string_helpers.c:980!
> ...
> [ 92.409141][ T1] RIP: 0010:fortify_panic (fbdev.c:?)
> ...
> [ 92.410056][ T1] ni_assign_device_routes (fbdev.c:?)
> [ 92.410056][ T1] ? unittest_enter (fbdev.c:?)
> [ 92.410056][ T1] ni_routes_unittest (ni_routes_test.c:?)
> [ 92.410056][ T1] ? unittest_enter (fbdev.c:?)
> [ 92.410056][ T1] __initstub__kmod_ni_routes_test__505_604_ni_routes_unittest6 (fbdev.c:?)
> [ 92.410056][ T1] do_one_initcall (fbdev.c:?)
> 
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Spencer E. Olson <olsonse@umich.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/lkml/20220210072821.GD4074@xsang-OptiPlex-9020
> Fixes: 4bb90c87abbe ("staging: comedi: add interface to ni routing table information")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/comedi/drivers/ni_routes.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
> index f24eeb464eba..295a3a9ee0c9 100644
> --- a/drivers/comedi/drivers/ni_routes.c
> +++ b/drivers/comedi/drivers/ni_routes.c
> @@ -56,8 +56,7 @@ static const u8 *ni_find_route_values(const char *device_family)
>   	int i;
>   
>   	for (i = 0; ni_all_route_values[i]; ++i) {
> -		if (memcmp(ni_all_route_values[i]->family, device_family,
> -			   strnlen(device_family, 30)) == 0) {
> +		if (!strcmp(ni_all_route_values[i]->family, device_family)) {
>   			rv = &ni_all_route_values[i]->register_values[0][0];
>   			break;
>   		}
> @@ -75,8 +74,7 @@ ni_find_valid_routes(const char *board_name)
>   	int i;
>   
>   	for (i = 0; ni_device_routes_list[i]; ++i) {
> -		if (memcmp(ni_device_routes_list[i]->device, board_name,
> -			   strnlen(board_name, 30)) == 0) {
> +		if (!strcmp(ni_device_routes_list[i]->device, board_name)) {
>   			dr = ni_device_routes_list[i];
>   			break;
>   		}

Looks good, thanks!  I'm not sure why the tests used memcmp() like that. 
Indeed, all the strings are statically allocated and null-terminated.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
