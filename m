Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74446E3CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhLIINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:13:25 -0500
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:54693 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhLIINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:13:24 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 03:13:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1639037392; x=1670573392;
  h=mime-version:from:date:message-id:subject:to;
  bh=dwrzKGkrbhqPejgYMu3fnvpsPF6iyB3v31qaNN+PHyY=;
  b=fbdmFT/WiyNUGq8NqfpGKoTOLwZ9Jr3JzRgHUPcmdu7GQGYiAWVPHJLu
   v/l+5xaQuDtRC+syvaWQ85aHuqfsvEcKu1YcEFfRylq/ynC8R84PclYhO
   +tv+V56N/eBKEBbaazefSL9fCh2AIsXHh52Y99lJOUttioWu4Vuc83hWS
   sfJAQvJWDjFqougbtk32pLyi1qaHWlk7W4L2BxWUCIUnkHxWoBJyiZ23v
   s3ZR0jZ1exzudFquxxHMXSuAhnxDxWW/vIAzw/33V+UGwjjMM9acVdaoJ
   THS/d+W9adBQVbr1k6ja/cUZIJj2HPD0oh29hwiTP2O3I8rxMCU/Dfbyf
   w==;
IronPort-SDR: DssgtsK2GaAksYToeW1onMO5MvUsSOMlLiyNRDvsKoGtjHpXIGR9IumFJLkWHietWagPpcIaEi
 5weGeM2O3UsCwEznDLCJLvz/5c9qkM6+6GHFaf1G/FnwOLARaKLGyRXCYaNwKqz6V/kEoy2Dnp
 fWUkn6sD1FNUkvkwLjY2WnTu/acEyaefpkoQS+/3DO66+ALnuhQMKok1BGXjziFtHP8UH7B6R+
 Vu9r82HBKc7ozsZWuSVJ2jHdKehMb4n7MNc52/JqbA/nC6w8wGBY04mvSocDHnqt91PQ87As3i
 +FU+LxYUgwydbqTRpmtjwNcG
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="92964143"
Received: from mail-yb1-f200.google.com ([209.85.219.200])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2021 00:02:47 -0800
Received: by mail-yb1-f200.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so9198327ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 00:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=mime-version:from:date:message-id:subject:to;
        bh=FO/o6XGFp/MRxtI8YH+3dBjf/TITwRdxcsJH3FJWYro=;
        b=t1s2ln+KuTv0vtVTsi6EEL3lVej0+vwpB4bXYl9jV3T86wNpmmJtTG52CTYxRl2HX/
         C/lcRRU7m2gTCaF7HTTFo/7TB6k/6xHGoZF0MDRuMZBsPiKzcllb1pace3tKXOTIsKGF
         0AAzDKL8xUooJT9j0qaIzMnRMQAXSZG1x+96U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FO/o6XGFp/MRxtI8YH+3dBjf/TITwRdxcsJH3FJWYro=;
        b=m+RlUNKkjbyFUg1Qi8nOYL8jikK1fvEkfUk4X7wsNYb3Dfc76i1AM9YpEWKEodYdFy
         Oy3zyPmG1bbkwekbHu0ZpOmE0m4SdsHOSMse3uo1e+kjY1Kks9LRg7Bg6JC59XEfhiEd
         8uaF6S7Abfgj6XWeJFRNx4c3i99oxo0wPOjeX4OZS6WiOkok+f2HRbmJTzg+NEU7KAu2
         NoFsxJIZZ/rriVN+WGoYWWj2Sx7xVGC9PEcSGfBunNcE/ZybiZBpjj5L/dRD5VJxILyX
         yaOc5M9smfwT8EX0DehjyNgpvFJSNzaGWze7uG/XZD36LPkhjCaYq4sb8DsgNWeyDjpL
         ZiMA==
X-Gm-Message-State: AOAM533BIZ4nvZV/9rT1YZ2UxCDNKK8cSpGTHraEofqjpr+dw6LyEPib
        ayHAJVz2C+GQFP+68gqvkMZ3oa9AV8VXU1LoKvIr1P/D56LFk8pxWNkpv0UgIH/BIuC/nbbLJ4L
        fWw3ASj9+c8kwosevyNteCgImy8Gqf1V4i8dUjtAjhQ==
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr4713162ybn.473.1639036965855;
        Thu, 09 Dec 2021 00:02:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWWRUv7JLzhNaIKlyfA820bGMFiWGdwThJIEjD9Cqct6sVTBRUgx4hBb42/x//CxAoiIHHteaSuBGElRn+grI=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr4713143ybn.473.1639036965686;
 Thu, 09 Dec 2021 00:02:45 -0800 (PST)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 9 Dec 2021 00:02:35 -0800
Message-ID: <CABvMjLSXpg00KKkqXH35C7Op0xC3mPaOAhj_xbAOEXL_4Ys_aw@mail.gmail.com>
Subject: Potential Bug in drm/amd/display/dc_link
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
I just found a bug in the cramfs using the static analysis tool, but
not sure if this could happen in reality, could you please advise me
here? Thanks for your attention : ) And please ignore the last one
with HTML format if you did not filter it out.

In function enable_stream_features(), the variable
"old_downspread.raw" could be uninitialized if core_link_read_dpcd
fails(), however, it is used in the later if statement, and further,
core_link_write_dpcd() may write random value, which is potentially
unsafe. But this function does not return the error code to the up
caller and I got stuck in drafting the patch, could you please advise
me here?

The related code:
static void enable_stream_features(struct pipe_ctx *pipe_ctx)
{
     union down_spread_ctrl old_downspread;
    core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
                         &old_downspread.raw, sizeof(old_downspread);

        //old_downspread.raw used here
        if (new_downspread.raw != old_downspread.raw) {
               core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
                         &new_downspread.raw, sizeof(new_downspread));
        }
}
enum dc_status core_link_read_dpcd(
    struct dc_link *link,
    uint32_t address,
    uint8_t *data,
    uint32_t size)
{
        //data could be uninitialized if the helpers fails and log
some error info
        if (!dm_helpers_dp_read_dpcd(link->ctx,
               link,address, data, size))
                      return DC_ERROR_UNEXPECTED;
        return DC_OK;
}

The same issue in function wait_for_training_aux_rd_interval() in
drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
