Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1A4D7D66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiCNINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiCNINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94E52E097
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647245519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3fpUD1WBNJDewOagkvGRBUT0zzMkStT2pshcTX95+8=;
        b=g8v5ZGIP0ia828j8qMaa/QrStDG1Yg6DjysaSb5+JrxR6cwGY+yf59jOhdraFUx5gtqvVV
        EeU1cF/XgPXAuJqQ0pB97YuHCGtNs67uVjgrqwzRl2WGVsLoCT2knvcv5ORtFoY8UxSimW
        HD63b2lJZZRgfNZeNMmlZhPXygOB8Bo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-XB3U27EkODunVOXDt7E-wA-1; Mon, 14 Mar 2022 04:11:57 -0400
X-MC-Unique: XB3U27EkODunVOXDt7E-wA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3941C185A79C;
        Mon, 14 Mar 2022 08:11:57 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782EB40D019C;
        Mon, 14 Mar 2022 08:11:50 +0000 (UTC)
Date:   Mon, 14 Mar 2022 16:11:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Yu Kuai <yukuai3@huawei.com>, Saravanan D <saravanand@fb.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: Re: [PATCH block-5.17] fix rq-qos breakage from skipping
 rq_qos_done_bio()
Message-ID: <Yi74wAHBvU+8QGrP@T590>
References: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 09:15:02PM -1000, Tejun Heo wrote:
> a647a524a467 ("block: don't call rq_qos_ops->done_bio if the bio isn't
> tracked") made bio_endio() skip rq_qos_done_bio() if BIO_TRACKED is not set.
> While this fixed a potential oops, it also broke blk-iocost by skipping the
> done_bio callback for merged bios.
> 
> Before, whether a bio goes through rq_qos_throttle() or rq_qos_merge(),
> rq_qos_done_bio() would be called on the bio on completion with BIO_TRACKED
> distinguishing the former from the latter. rq_qos_done_bio() is not called
> for bios which wenth through rq_qos_merge(). This royally confuses
> blk-iocost as the merged bios never finish and are considered perpetually
> in-flight.
> 
> One reliably reproducible failure mode is an intermediate cgroup geting
> stuck active preventing its children from being activated due to the
> leaf-only rule, leading to loss of control. The following is from
> resctl-bench protection scenario which emulates isolating a web server like
> workload from a memory bomb run on an iocost configuration which should
> yield a reasonable level of protection.
> 
>   # cat /sys/block/nvme2n1/device/model
>   Samsung SSD 970 PRO 512GB               
>   # cat /sys/fs/cgroup/io.cost.model
>   259:0 ctrl=user model=linear rbps=834913556 rseqiops=93622 rrandiops=102913 wbps=618985353 wseqiops=72325 wrandiops=71025
>   # cat /sys/fs/cgroup/io.cost.qos
>   259:0 enable=1 ctrl=user rpct=95.00 rlat=18776 wpct=95.00 wlat=8897 min=60.00 max=100.00
>   # resctl-bench -m 29.6G -r out.json run protection::scenario=mem-hog,loops=1
>   ...
>   Memory Hog Summary
>   ==================
> 
>   IO Latency: R p50=242u:336u/2.5m p90=794u:1.4m/7.5m p99=2.7m:8.0m/62.5m max=8.0m:36.4m/350m
>               W p50=221u:323u/1.5m p90=709u:1.2m/5.5m p99=1.5m:2.5m/9.5m max=6.9m:35.9m/350m
> 
>   Isolation and Request Latency Impact Distributions:
> 
>                 min   p01   p05   p10   p25   p50   p75   p90   p95   p99   max  mean stdev
>   isol%       15.90 15.90 15.90 40.05 57.24 59.07 60.01 74.63 74.63 90.35 90.35 58.12 15.82 
>   lat-imp%        0     0     0     0     0  4.55 14.68 15.54 233.5 548.1 548.1 53.88 143.6 
> 
>   Result: isol=58.12:15.82% lat_imp=53.88%:143.6 work_csv=100.0% missing=3.96%
> 
> The isolation result of 58.12% is close to what this device would show
> without any IO control.
> 
> Fix it by introducing a new flag BIO_QOS_MERGED to mark merged bios and
> calling rq_qos_done_bio() on them too. For consistency and clarity, rename
> BIO_TRACKED to BIO_QOS_THROTTLED. The flag checks are moved into
> rq_qos_done_bio() so that it's next to the code paths that set the flags.
> 
> With the patch applied, the above same benchmark shows:
> 
>   # resctl-bench -m 29.6G -r out.json run protection::scenario=mem-hog,loops=1
>   ...
>   Memory Hog Summary
>   ==================
> 
>   IO Latency: R p50=123u:84.4u/985u p90=322u:256u/2.5m p99=1.6m:1.4m/9.5m max=11.1m:36.0m/350m
>               W p50=429u:274u/995u p90=1.7m:1.3m/4.5m p99=3.4m:2.7m/11.5m max=7.9m:5.9m/26.5m
> 
>   Isolation and Request Latency Impact Distributions:
> 
>                 min   p01   p05   p10   p25   p50   p75   p90   p95   p99   max  mean stdev
>   isol%       84.91 84.91 89.51 90.73 92.31 94.49 96.36 98.04 98.71 100.0 100.0 94.42  2.81 
>   lat-imp%        0     0     0     0     0  2.81  5.73 11.11 13.92 17.53 22.61  4.10  4.68 
> 
>   Result: isol=94.42:2.81% lat_imp=4.10%:4.68 work_csv=58.34% missing=0%
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: a647a524a467 ("block: don't call rq_qos_ops->done_bio if the bio isn't tracked")
> Cc: stable@vger.kernel.org # v5.15+
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Yu Kuai <yukuai3@huawei.com>

Looks fine since rq always holds one .q_usage_counter in case of merge:

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

