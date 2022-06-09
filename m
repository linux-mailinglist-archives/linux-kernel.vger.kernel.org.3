Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607C3544703
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiFIJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiFIJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:13:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECD13E2B;
        Thu,  9 Jun 2022 02:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFFDEB82C94;
        Thu,  9 Jun 2022 09:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A81C3411B;
        Thu,  9 Jun 2022 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654766032;
        bh=E3bgvVQEVSUMixTXedD3mOG5QZ6LUdmLCyjdbt8AWbg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=i0tUtRLBPi9KbygmHDvfAoSYRE2VoyO0fZhW0K9f446PIp8jIptyuAPZo3IMkt7LY
         PT2VwNLypWsI0JFTMstHO1FU1gLxOoFhCIsJfkkDtUdS01/vR3lsnjeLmBMh//IJxX
         nitnGWUNpnVr73xbbEPLp4El0USYqGhRVS//2FgCyxznu4QY2ZHZWEUsSApftb5tas
         KiGsZedGT2FzyCNdzwpy8NeTgDTtn+Y/xgVfnsIwjzj+sOwoaNx8fetO8YobFkRB65
         fvNkbc1Lqrqp26dmYvTOHclfgk1T943U5BngVkjy1Zfy95KMAy4GP+/ZdD9PG5Lsj9
         67FNbDo8w5eWg==
Date:   Thu, 9 Jun 2022 11:13:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tao Jin <tao-j@outlook.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hid: multitouch: new device class fix Lenovo X12
 trackpad sticky
In-Reply-To: <CO6PR03MB62414DD2A91566B0D4C1C1DDE1D39@CO6PR03MB6241.namprd03.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2206091113370.14340@cbobk.fhfr.pm>
References: <CO6PR03MB62414DD2A91566B0D4C1C1DDE1D39@CO6PR03MB6241.namprd03.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022, Tao Jin wrote:

> The trackpad of the given device sends continuous report of pointers
> status as per wxn8 spec. However, the spec did not clarify when the
> fingers are lifted so fast that between the interval of two report
> frames fingers on pad reduced from >=2 to 0. The second last report
> contains >=2 fingers with tip state 1 and the last report contains only
> 1 finger with tip state 0. Although this can happen unfrequently, a
>   quick fix will be improve the consistency to 100%. A quick fix is to
> disable MT_QUIRK_ALWAYS_VALID and enable MT_QUIRK_NOT_SEEN_MEANS_UP.
> 
> Test for hid-tools is added in [1]
> 
> In addition to this, I2C device 04CA:00B1 may also need similar class
> but with MT_QUIRK_FORCE_MULTI_INPUT disabled (but it does not harm to
>  enable it on non-multi-input device either). The respective owner has
> been notified and a patch may coming soon after test.
> 
> [1]: https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/130
> 
> Signed-off-by: Tao Jin <tao-j@outlook.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

