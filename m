Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F355079C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiFSABo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4FE0B4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 018EA60C60
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A07DC3411A;
        Sun, 19 Jun 2022 00:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655596900;
        bh=4uZ3w8KpztyoIhhdswu8fmZ99307UAhVHd/s9nQ5sTc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mJ8C++Oe0oYGN98XUZKsOzfHXGIpjQ9j3VfnHrTBFtNpc5BS0E19tvzrnHlMthMaK
         ImqrSPz26HO51t4EcIumlZEREkSBgD6dRvIdexi7T81LywdhFTMwEW/PyyRxMRqUzo
         rpkP1d6Yros64AKvKQOhrqYXa4f6UDiU0l2YIe3qtldfWOQpn94Th19EdrH4tE2KqE
         dPYlPQpplEMlkR9acN3++b1zB0vm4INDJVSBCbrak+h7G2CWHc2+I5GxMS2n9e+/cx
         /ssvU3wRxWnkIhslWG1w4mLlCAh85vMjdxipXhAATBaldl1ldAGKAXvYYRJZIGRVlY
         PVlEra9Ye/qjQ==
Message-ID: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
Date:   Sun, 19 Jun 2022 08:01:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] resize.f2fs: add option to manually specify new
 overprovision
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12 <liuchao12@xiaomi.com>
References: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 19:49, qixiaoyu1 wrote:
> From: liuchao12 <liuchao12@xiaomi.com>
> 
> Make.f2fs supports manually specifying overprovision, and we expect
> resize.f2fs to support it as well.
> 
> This change add a new '-o' option to manually specify overprovision.
> 
> Signed-off-by: liuchao12 <liuchao12@xiaomi.com>
> ---
>   fsck/main.c   |  8 ++++++--
>   fsck/resize.c | 12 ++++++++++--
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index aef797e..3b4da0f 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -121,7 +121,8 @@ void resize_usage()
>   	MSG(0, "[options]:\n");
>   	MSG(0, "  -d debug level [default:0]\n");
>   	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
> -	MSG(0, "  -s safe resize (Does not resize metadata)");
> +	MSG(0, "  -o overprovision percentage [default:auto]\n");

Should update manual as well?

> +	MSG(0, "  -s safe resize (Does not resize metadata)\n");
>   	MSG(0, "  -t target sectors [default: device size]\n");
>   	MSG(0, "  -V print the version number and exit\n");
>   	exit(1);
> @@ -527,7 +528,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   #endif
>   	} else if (!strcmp("resize.f2fs", prog)) {
>   #ifdef WITH_RESIZE
> -		const char *option_string = "d:fst:iV";
> +		const char *option_string = "d:fst:io:V";
>   
>   		c.func = RESIZE;
>   		while ((option = getopt(argc, argv, option_string)) != EOF) {
> @@ -561,6 +562,9 @@ void f2fs_parse_options(int argc, char *argv[])
>   			case 'i':
>   				c.large_nat_bitmap = 1;
>   				break;
> +			case 'o':
> +				c.new_overprovision = atof(optarg);
> +				break;
>   			case 'V':
>   				show_version(prog);
>   				exit(0);
> diff --git a/fsck/resize.c b/fsck/resize.c
> index f1b7701..d19c6fa 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -146,12 +146,15 @@ safe_resize:
>   						get_sb(segs_per_sec));
>   
>   	/* Let's determine the best reserved and overprovisioned space */
> -	c.new_overprovision = get_best_overprovision(sb);
> +	if (c.new_overprovision == 0)
> +		c.new_overprovision = get_best_overprovision(sb);
> +
>   	c.new_reserved_segments =
>   		(2 * (100 / c.new_overprovision + 1) + 6) *
>   						get_sb(segs_per_sec);
>   
> -	if ((get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
> +	if (c.new_overprovision == 0 ||

Should never be zero here? Otherwise above "100 / c.new_overprovision"
calculation will cause arithmetic exception.

Thanks,

> +		(get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
>   		get_sb(segment_count_main) * blks_per_seg >
>   						get_sb(block_count)) {
>   		MSG(0, "\tError: Device size is not sufficient for F2FS volume, "
> @@ -476,6 +479,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
>   	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
>   						get_cp(rsvd_segment_count));
>   
> +	DBG(0, "Info: Overprovision ratio = %.3lf%%\n", c.new_overprovision);
> +	DBG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
> +					get_cp(overprov_segment_count),
> +					c.new_reserved_segments);
> +
>   	free_segment_count = get_free_segments(sbi);
>   	new_segment_count = get_newsb(segment_count_main) -
>   					get_sb(segment_count_main);
