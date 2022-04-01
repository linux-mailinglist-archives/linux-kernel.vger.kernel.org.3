Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF64EE605
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiDAC3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244068AbiDAC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:28:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2A255A8E;
        Thu, 31 Mar 2022 19:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2063BB82201;
        Fri,  1 Apr 2022 02:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E048C340ED;
        Fri,  1 Apr 2022 02:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648780028;
        bh=nBYzy51cnyAKW9oy9okRIcSO8R9iuWITzppuXcOQxGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7QTln4hskTdPSmj1zc5lLhHekbXWXFcpO7fOwmPhs+yxFWS8XCIUXMA2YupyhDML
         L19oT9c9jq78Ho+/sbzgIyP1sCYO/O1bZR/3TbdeiM/q3mLEK3SZco/rtUESPD3BEM
         BHkf7opbKhzfuMWvpWJKNIzmFXKl6W+icZfRAI0n0tDMp38sjF0eDaSyQ86UsqLJUg
         +MfCQqWBv2sMxjfD+lsBhel2i/knrAcvjGmoACfj7OJPW8a21Bi0XulFyO0T6sAeWU
         hLkzZFxiGSM4/mrHwUmC2lcXyWRvuVlmQsMNzaw+bHRS228uSIouTmbRy3rlBuHa8t
         hWXNVDppvaJjw==
Date:   Thu, 31 Mar 2022 20:27:05 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Michael Marod <michael@michaelmarod.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: NVME performance regression in Linux 5.x due to lack of block
 level IO queueing
Message-ID: <YkZi+co1HchfRafa@kbusch-mbp.dhcp.thefacebook.com>
References: <51E3A396-F68B-496D-AE36-B0457A3B0968@michaelmarod.com>
 <847D3821-1D92-468C-88C3-34284BA7922E@michaelmarod.com>
 <C06B8EF0-BF3B-4F14-994F-F80B5102D538@michaelmarod.com>
 <YkUvgu6VxNORv8M6@infradead.org>
 <4034AD9F-2A6A-4AE6-B5FC-58FC2BC238F5@michaelmarod.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4034AD9F-2A6A-4AE6-B5FC-58FC2BC238F5@michaelmarod.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:22:03PM +0000, Michael Marod wrote:
> # /usr/local/bin/fio -name=randrw -filename=/opt/foo -direct=1 -iodepth=1 -thread -rw=randrw -ioengine=psync -bs=4k -size=10G -numjobs=16 -group_reporting=1 -runtime=120
> 
> // Ubuntu 16.04 / Linux 4.4.0:
> Run status group 0 (all jobs):
>    READ: bw=54.5MiB/s (57.1MB/s), 54.5MiB/s-54.5MiB/s (57.1MB/s-57.1MB/s), io=6537MiB (6854MB), run=120002-120002msec
>   WRITE: bw=54.5MiB/s (57.2MB/s), 54.5MiB/s-54.5MiB/s (57.2MB/s-57.2MB/s), io=6544MiB (6862MB), run=120002-120002msec
> 
> // Ubuntu 18.04 / Linux 5.4.0:
> Run status group 0 (all jobs):
>    READ: bw=23.5MiB/s (24.7MB/s), 23.5MiB/s-23.5MiB/s (24.7MB/s-24.7MB/s), io=2821MiB (2959MB), run=120002-120002msec
>   WRITE: bw=23.5MiB/s (24.6MB/s), 23.5MiB/s-23.5MiB/s (24.6MB/s-24.6MB/s), io=2819MiB (2955MB), run=120002-120002msec
> 
> // Ubuntu 18.04 / Linux 5.17:
> Run status group 0 (all jobs):
>    READ: bw=244MiB/s (255MB/s), 244MiB/s-244MiB/s (255MB/s-255MB/s), io=28.6GiB (30.7GB), run=120001-120001msec
>   WRITE: bw=244MiB/s (256MB/s), 244MiB/s-244MiB/s (256MB/s-256MB/s), io=28.6GiB (30.7GB), run=120001-120001msec

Thanks for the info. I don't know of anything block or nvme specific that might
explain an order of magnitude perf difference.

Could you try the same test without the filesytems? You mentioned using mdraid,
so try '--filename=/dev/mdX'. If that also shows similiar performance
difference, try using one of your nvme member drives directly, like
'--filename=/dev/nvme1n1'. That should isolate which subsystem is contributing
to the difference.
