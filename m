Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0474B772F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiBORKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:10:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbiBORKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:10:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738211ADE0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:10:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id om7so17888035pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AQ3fDRtvvAyzaRgSkF0LYg6RwPkLq09gWACdozQx0Q=;
        b=L4wjQK2R+nFSvB72daAn6OGqEY0e4pOnuhk+oJiwmMHAAxaK2+P0PEdTU11O9lwqZZ
         LFHoPKhbGnjMnt/m1cNgpWP7ZZ/ek4MYdk67fwf5iAgVCEVVDDkhIk8TfnCafM6jVzcT
         kLNGqjkSTvoDs8oWCLhi1RYfgSpCvoQNyS32c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AQ3fDRtvvAyzaRgSkF0LYg6RwPkLq09gWACdozQx0Q=;
        b=n1nd54aocHEPW7Bq+Mkv33y4jZ9qHGCVJ5FjoGAnIkA9uuRaONAT/CDDMpsE2+/0QE
         zEsRepeTil0hhUkbwoIfDrR70lj+EPIo4rSFrfR5gtG6pOcuujnllUsRtXl3re3Y70Rm
         QeV53yihQbDoeeRc0HXSmiVIgrVBVtMQPMeK0s45udlGYoGNbdd6xkV7dDh6V6rZ93QZ
         oDT0cI/GXZT5j5q7qrALp97f5jOw2fSL+/TKRIzT5LLFas1YkemOighvi6zWFFjnKjb+
         /AC4BJ7P34Y7GzZoakG3HZhC/OHqlMZ1krcLXBxE8vUgjy85stDzT5xhHxQC9bDbn2G3
         /OlQ==
X-Gm-Message-State: AOAM531HPOa0Ul9k1g5693vEakZhOid3zHec3omcQ3pUPS10dQi/Adz5
        0TLsmJiZpuZO4jKZxuav9sRwlw==
X-Google-Smtp-Source: ABdhPJzPp0hoGJWOBEEd1ZJ3T/gU+VW5YsLYIZ9vHQ6CchAboPnzc3Hqmdy/mRblfujYZ1UN8XzDew==
X-Received: by 2002:a17:90a:2d6:b0:1b8:cd70:697d with SMTP id d22-20020a17090a02d600b001b8cd70697dmr5562639pjd.78.1644945019569;
        Tue, 15 Feb 2022 09:10:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm6437383pfc.217.2022.02.15.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:19 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Spencer E . Olson" <olsonse@umich.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] comedi: drivers: ni_routes: Use strcmp() instead of memcmp()
Date:   Tue, 15 Feb 2022 09:10:17 -0800
Message-Id: <20220215171017.1247291-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; h=from:subject; bh=x3hZzfhfyuYZzBCCKAEKJ9M0LltxNUKCLv4uNIlURXc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiC955NMBJIi1SxE4z6UctWoNzM+jvDdkD6X+cI07+ WvCpt7CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgveeQAKCRCJcvTf3G3AJsSxEA CfcOQ5jzG/KZtKqlKFlvBUL84XUXdRay9zrcwxzoplnOS7gSKlri+QzxBmgkYbqAX+xqNzD6UP1T+n h7vsq+581GLytF34tIJlI1P+mg7q+tC601Z/NaT8Zsjpt6nKh28/iA2nEfh9xe+3j4o0dU6fTGPAP+ M+rIwdpviImX5Q3BYnTDgmX+JvibsTNILP5VxBTgx2Cwcp6kDtGWhdAoJw3KF/6cZciByShBQ5nVg8 JbK3Zu57FlcSSO3Ct5pKYp3a6eO/Zp6E8KFRVtJ7VagVNR6+N+5VZ9SQgyLPeJyKNLoMCC/qyquD57 OMIdEFr9hOVYbDEcBMsY2ArvM8sd5e162GOeTgIEp5sbDNyruUqw5Eh0u5LZdHYh8mHDs3MJDW91an ySSN8QCJdKcx5jAEthpc4q7tftca2crUNHhpd4iH7b1Q9asJGFYnupoYBfA+fkLXn7FC+GcCyb2rNz YRMIKvZ+3mS+EisTkA2bKeHoHZAqQ417lHHpxKEo+4NidzXywJr3UoTk3ce/Egvma9q9ytZ/R/DG3t GPzbRQHuiJyv2S5a1kxaI8GE0fNypLG+Rso4LJgpD6XHGotOWU9qiNQCxYNnvVlOWKBrM9YVH64vDQ tJ8qg5ttjQlO8heC4gTBbundoJmFNXnuAMchK+p63/s32T7ehJ82u5llBf/g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The family and device comparisons were using memcmp(), but this could
lead to Out-of-bounds reads when the length was larger than the
buffers being compared. Since these appear to always be NUL-terminated
strings, just use strcmp() instead.

This was found with Clang under LTO:

[ 92.405851][    T1] kernel BUG at lib/string_helpers.c:980!
...
[ 92.409141][ T1] RIP: 0010:fortify_panic (fbdev.c:?)
...
[ 92.410056][ T1] ni_assign_device_routes (fbdev.c:?)
[ 92.410056][ T1] ? unittest_enter (fbdev.c:?)
[ 92.410056][ T1] ni_routes_unittest (ni_routes_test.c:?)
[ 92.410056][ T1] ? unittest_enter (fbdev.c:?)
[ 92.410056][ T1] __initstub__kmod_ni_routes_test__505_604_ni_routes_unittest6 (fbdev.c:?)
[ 92.410056][ T1] do_one_initcall (fbdev.c:?)

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Spencer E. Olson <olsonse@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/lkml/20220210072821.GD4074@xsang-OptiPlex-9020
Fixes: 4bb90c87abbe ("staging: comedi: add interface to ni routing table information")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/comedi/drivers/ni_routes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
index f24eeb464eba..295a3a9ee0c9 100644
--- a/drivers/comedi/drivers/ni_routes.c
+++ b/drivers/comedi/drivers/ni_routes.c
@@ -56,8 +56,7 @@ static const u8 *ni_find_route_values(const char *device_family)
 	int i;
 
 	for (i = 0; ni_all_route_values[i]; ++i) {
-		if (memcmp(ni_all_route_values[i]->family, device_family,
-			   strnlen(device_family, 30)) == 0) {
+		if (!strcmp(ni_all_route_values[i]->family, device_family)) {
 			rv = &ni_all_route_values[i]->register_values[0][0];
 			break;
 		}
@@ -75,8 +74,7 @@ ni_find_valid_routes(const char *board_name)
 	int i;
 
 	for (i = 0; ni_device_routes_list[i]; ++i) {
-		if (memcmp(ni_device_routes_list[i]->device, board_name,
-			   strnlen(board_name, 30)) == 0) {
+		if (!strcmp(ni_device_routes_list[i]->device, board_name)) {
 			dr = ni_device_routes_list[i];
 			break;
 		}
-- 
2.30.2

