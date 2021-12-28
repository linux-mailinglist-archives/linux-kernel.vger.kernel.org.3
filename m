Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB464809C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhL1Nv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:51:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:44840 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhL1Nv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640699516; x=1672235516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cylpDz+UcTUxElNJSG3CKLXtdiZsGOydm15xFSUy2nw=;
  b=Ga0f13WOFvukN81m0JIfPyinYZHWFoAMlIbar8tfMomiQH9lKxjRqb1X
   kyTQYieTmT61pbyp+mRZwSj9l8utwB3janPUuoPIeuTH07kTX1RHYxQiv
   WCcDczyZCYUJ69MZpgJQ8POVd4nVixF2vxTMoYd62dml7L7y/Pt3ZG7mV
   v3q+WUFPha+hZSWYhoz/lO3nBkFRLCqgqQWvoeLbz38+aYgoVnaWezQY8
   sTD0o9mFrt+ovrI1gqkwZo3kAnIrYk+LavM7RIgHroP4+9Zmnwqn3hcie
   AZnhOBq3xS0dmlal3eJa62PoOkkurKoTLF9M3Q4aiPq3yl3+F+FXd+PgO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="240150352"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="240150352"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 05:51:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="523640199"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 05:51:50 -0800
Date:   Tue, 28 Dec 2021 21:49:27 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Dexuan Cui <decui@microsoft.com>, Jens Axboe <axboe@kernel.dk>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: RE: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Message-ID: <20211228134926.GA31268@xsang-OptiPlex-9020>
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
 <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
 <BYAPR21MB127067C16809209C019BC83BBF7B9@BYAPR21MB1270.namprd21.prod.outlook.com>
 <27973649-193d-a485-1ca7-983a53c7cf78@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27973649-193d-a485-1ca7-983a53c7cf78@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Jens, Dexuan,

On Tue, Dec 28, 2021 at 10:30:43AM +0800, Yin Fengwei wrote:
> Hi Jens, Dexuan,
> 
> On 12/20/2021 1:15 PM, Dexuan Cui wrote:
> >> From: Jens Axboe <axboe@kernel.dk>
> >> Sent: Sunday, December 19, 2021 7:28 AM
> >>> ...
> >>> Dexuan, can you test this for your test case too? I'm going to queue
> >>> up a revert for -rc6 just in case.
> >>
> >> This one should be better...
> >> ...
> >> Jens Axboe
> > 
> > Hi Jens, sorry -- unluckily I lost the test environment.. :-(
> > I pinged the user to set up the test environment again, but he's
> > on vacation till the beginning of January.
> 
> We hit this issue in our testing env also and will help to verify
> your fixing patch. Thanks.

as we reported in [1], we found cb2ac2912a cause big regressions in fxmark
tests.
"[block]  cb2ac2912a: fxmark.ssd_f2fs_dbench_client_4_bufferedio.works/sec -66.0% regression"

By applying the patch supplied by Jens Axboe in previous thread directly
upon cb2ac2912a, we confirmed the regression could be fixed:

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/bufferedio/1SSD/f2fs/x86_64-rhel-8.3/ssd/debian-10.4-x86_64-20200603.cgz/lkp-snr-a1/dbench_client/fxmark/0x9c02000e

commit:
  edaa26334c ("iocost: Fix divide-by-zero on donation from low hweight cgroup")
  cb2ac2912a ("block: reduce kblockd_mod_delayed_work_on() CPU consumption")
  80f0eab183 (fix for very low IOPS due to "block: reduce kblockd_mod_delayed_work_on() CPU consumption") <-- patch by Jens Axboe

edaa26334c117a58 cb2ac2912a9ca7d3d26291c5119 80f0eab18356919a1c0568c6348
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    573.42           -66.0%     194.68            -0.6%     570.11        fxmark.ssd_f2fs_dbench_client_4_bufferedio.works/sec

actually there are other subtests which either have regressions also fixed
by new patch, or we didn't observe obvious performance changes.

edaa26334c117a58 cb2ac2912a9ca7d3d26291c5119 80f0eab18356919a1c0568c6348
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    574.25           -18.5%     468.11            -0.4%     571.83        fxmark.ssd_f2fs_dbench_client_18_bufferedio.works/sec
    495.79            +0.2%     496.65            -0.6%     493.04        fxmark.ssd_f2fs_dbench_client_1_bufferedio.works/sec
    536.81           -72.8%     145.99 ± 19%      -0.6%     533.78        fxmark.ssd_f2fs_dbench_client_2_bufferedio.works/sec
    544.81            +1.8%     554.73            -0.1%     544.26        fxmark.ssd_f2fs_dbench_client_36_bufferedio.works/sec
    513.26 ±  2%      +2.5%     526.05 ±  3%      -1.8%     504.04        fxmark.ssd_f2fs_dbench_client_54_bufferedio.works/sec
    513.10 ±  4%      +3.9%     533.07 ±  3%      -0.7%     509.73 ±  5%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.works/sec


also attached detail comparison table edaa26334c-cb2ac2912a-80f0eab183
which contains futher details such like perf data.


[1] https://lore.kernel.org/lkml/20211219141852.GH14057@xsang-OptiPlex-9020/


> 
> 
> Regards
> Yin, Fengwei

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=edaa26334c-cb2ac2912a-80f0eab183
Content-Transfer-Encoding: 8bit

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/bufferedio/1SSD/f2fs/x86_64-rhel-8.3/ssd/debian-10.4-x86_64-20200603.cgz/lkp-snr-a1/dbench_client/fxmark/0x9c02000e

commit:
  edaa26334c ("iocost: Fix divide-by-zero on donation from low hweight cgroup")
  cb2ac2912a ("block: reduce kblockd_mod_delayed_work_on() CPU consumption")
  80f0eab183 (fix for very low IOPS due to "block: reduce kblockd_mod_delayed_work_on() CPU consumption") <-- patch by Jens Axboe

edaa26334c117a58 cb2ac2912a9ca7d3d26291c5119 80f0eab18356919a1c0568c6348
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      0.09 ±  4%      -1.8%       0.09            +2.5%       0.09 ±  5%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.idle_sec
      0.15 ±  4%      +0.7%       0.15            +2.5%       0.16 ±  5%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.idle_util
      0.05 ± 28%  +26109.7%      13.54 ±  6%     +18.1%       0.06 ± 26%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.iowait_sec
      0.09 ± 28%  +26775.3%      23.05 ±  7%     +18.0%       0.10 ± 26%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.iowait_util
      4.26           -20.9%       3.37 ± 15%      -3.3%       4.12 ±  9%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.irq_sec
      7.07           -18.9%       5.74 ± 15%      -3.3%       6.84 ±  9%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.irq_util
     18.00            +0.0%      18.00            +0.0%      18.00        fxmark.ssd_f2fs_dbench_client_18_bufferedio.ncpu
     60.24            +0.0%      60.24            +0.0%      60.24        fxmark.ssd_f2fs_dbench_client_18_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_18_bufferedio.secs
      1.07           -43.2%       0.61 ±  3%      +4.1%       1.11 ±  4%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.softirq_sec
      1.77           -41.8%       1.03 ±  3%      +4.1%       1.85 ±  4%  fxmark.ssd_f2fs_dbench_client_18_bufferedio.softirq_util
     39.66           -25.7%      29.47 ±  2%      +0.2%      39.74        fxmark.ssd_f2fs_dbench_client_18_bufferedio.sys_sec
     65.84           -23.8%      50.16 ±  2%      +0.2%      65.96        fxmark.ssd_f2fs_dbench_client_18_bufferedio.sys_util
     15.10           -22.7%      11.67            +0.1%      15.12        fxmark.ssd_f2fs_dbench_client_18_bufferedio.user_sec
     25.08           -20.8%      19.87            +0.1%      25.10        fxmark.ssd_f2fs_dbench_client_18_bufferedio.user_util
    574.25           -18.5%     468.11            -0.4%     571.83        fxmark.ssd_f2fs_dbench_client_18_bufferedio.works/sec
      0.11 ±  3%      -6.2%       0.10 ±  8%      +0.6%       0.11 ±  2%  fxmark.ssd_f2fs_dbench_client_1_bufferedio.idle_sec
      0.18 ±  3%      -5.4%       0.17 ±  8%      +0.3%       0.18 ±  3%  fxmark.ssd_f2fs_dbench_client_1_bufferedio.idle_util
     12.37            +1.3%      12.54            +0.5%      12.44        fxmark.ssd_f2fs_dbench_client_1_bufferedio.iowait_sec
     21.03            +2.2%      21.49            +0.2%      21.08        fxmark.ssd_f2fs_dbench_client_1_bufferedio.iowait_util
      4.04            -5.7%       3.81 ± 13%      -3.5%       3.90 ± 10%  fxmark.ssd_f2fs_dbench_client_1_bufferedio.irq_sec
      6.87            -5.0%       6.53 ± 13%      -3.8%       6.61 ±  9%  fxmark.ssd_f2fs_dbench_client_1_bufferedio.irq_util
      1.00            +0.0%       1.00            +0.0%       1.00        fxmark.ssd_f2fs_dbench_client_1_bufferedio.ncpu
     60.17            -0.0%      60.17            -0.0%      60.17        fxmark.ssd_f2fs_dbench_client_1_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_1_bufferedio.secs
      0.80            -2.7%       0.78            +1.5%       0.81 ±  3%  fxmark.ssd_f2fs_dbench_client_1_bufferedio.softirq_sec
      1.36            -1.9%       1.33            +1.2%       1.38 ±  3%  fxmark.ssd_f2fs_dbench_client_1_bufferedio.softirq_util
     29.14            -1.1%      28.82            -0.0%      29.14        fxmark.ssd_f2fs_dbench_client_1_bufferedio.sys_sec
     49.53            -0.3%      49.39            -0.3%      49.38        fxmark.ssd_f2fs_dbench_client_1_bufferedio.sys_util
     12.36            -0.6%      12.30            +2.0%      12.61        fxmark.ssd_f2fs_dbench_client_1_bufferedio.user_sec
     21.02            +0.3%      21.07            +1.7%      21.37        fxmark.ssd_f2fs_dbench_client_1_bufferedio.user_util
    495.79            +0.2%     496.65            -0.6%     493.04        fxmark.ssd_f2fs_dbench_client_1_bufferedio.works/sec
      0.10 ±  3%      -3.4%       0.10 ±  5%      -2.4%       0.10 ±  5%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.idle_sec
      0.17 ±  3%      -0.5%       0.17 ±  5%      -2.9%       0.16 ±  5%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.idle_util
      7.78 ±  3%    +458.1%      43.44 ±  6%      +0.7%       7.84 ±  3%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.iowait_sec
     13.26 ±  3%    +474.8%      76.21 ±  5%      +0.1%      13.28 ±  3%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.iowait_util
      4.16           -27.3%       3.03 ± 17%      -3.5%       4.02 ±  9%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.irq_sec
      7.10           -25.1%       5.32 ± 17%      -4.1%       6.81 ±  9%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.irq_util
      2.00            +0.0%       2.00            +0.0%       2.00        fxmark.ssd_f2fs_dbench_client_2_bufferedio.ncpu
     60.18            +0.0%      60.18            -0.0%      60.18        fxmark.ssd_f2fs_dbench_client_2_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_2_bufferedio.secs
      0.91           -68.7%       0.28 ± 18%      +1.9%       0.93 ±  3%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.softirq_sec
      1.55           -67.8%       0.50 ± 18%      +1.3%       1.57 ±  4%  fxmark.ssd_f2fs_dbench_client_2_bufferedio.softirq_util
     32.43           -77.8%       7.18 ± 22%      +0.8%      32.69        fxmark.ssd_f2fs_dbench_client_2_bufferedio.sys_sec
     55.25           -77.2%      12.61 ± 22%      +0.2%      55.36        fxmark.ssd_f2fs_dbench_client_2_bufferedio.sys_util
     13.31           -77.8%       2.96 ± 22%      +1.2%      13.47        fxmark.ssd_f2fs_dbench_client_2_bufferedio.user_sec
     22.67           -77.1%       5.19 ± 22%      +0.6%      22.82        fxmark.ssd_f2fs_dbench_client_2_bufferedio.user_util
    536.81           -72.8%     145.99 ± 19%      -0.6%     533.78        fxmark.ssd_f2fs_dbench_client_2_bufferedio.works/sec
      0.09            +3.7%       0.09 ±  5%      +3.3%       0.09 ±  4%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.idle_sec
      0.15            +4.2%       0.16 ±  5%      +3.3%       0.15 ±  4%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.idle_util
      0.06 ± 19%   +4041.0%       2.69 ± 10%      -3.1%       0.06 ± 22%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.iowait_sec
      0.11 ± 19%   +4061.6%       4.49 ± 10%      -3.1%       0.10 ± 22%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.iowait_util
      4.19           -15.8%       3.53 ± 14%      -3.4%       4.05 ±  9%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.irq_sec
      6.95           -15.4%       5.88 ± 14%      -3.4%       6.71 ±  9%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.irq_util
     36.00            +0.0%      36.00            +0.0%      36.00        fxmark.ssd_f2fs_dbench_client_36_bufferedio.ncpu
     60.32            -0.0%      60.31            -0.0%      60.31        fxmark.ssd_f2fs_dbench_client_36_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_36_bufferedio.secs
      0.98 ±  4%     -23.0%       0.76 ±  3%      +2.3%       1.01 ±  3%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.softirq_sec
      1.63 ±  4%     -22.6%       1.26 ±  3%      +2.3%       1.67 ±  3%  fxmark.ssd_f2fs_dbench_client_36_bufferedio.softirq_util
     40.18            -4.0%      38.57            -0.0%      40.17        fxmark.ssd_f2fs_dbench_client_36_bufferedio.sys_sec
     66.63            -3.5%      64.28            -0.0%      66.61        fxmark.ssd_f2fs_dbench_client_36_bufferedio.sys_util
     14.79            -2.9%      14.36            +0.9%      14.93        fxmark.ssd_f2fs_dbench_client_36_bufferedio.user_sec
     24.53            -2.4%      23.94            +0.9%      24.75        fxmark.ssd_f2fs_dbench_client_36_bufferedio.user_util
    544.81            +1.8%     554.73            -0.1%     544.26        fxmark.ssd_f2fs_dbench_client_36_bufferedio.works/sec
      0.10 ±  4%      -1.7%       0.10 ±  5%      -2.8%       0.09 ±  5%  fxmark.ssd_f2fs_dbench_client_4_bufferedio.idle_sec
      0.16 ±  4%      +3.7%       0.17 ±  5%      -2.8%       0.16 ±  5%  fxmark.ssd_f2fs_dbench_client_4_bufferedio.idle_util
      3.17 ±  4%   +1122.1%      38.74            +2.0%       3.23 ±  8%  fxmark.ssd_f2fs_dbench_client_4_bufferedio.iowait_sec
      5.31 ±  4%   +1189.4%      68.46            +1.9%       5.41 ±  8%  fxmark.ssd_f2fs_dbench_client_4_bufferedio.iowait_util
      4.23           -26.6%       3.11 ± 16%      -3.4%       4.09 ±  9%  fxmark.ssd_f2fs_dbench_client_4_bufferedio.irq_sec
      7.09           -22.5%       5.49 ± 16%      -3.5%       6.84 ±  9%  fxmark.ssd_f2fs_dbench_client_4_bufferedio.irq_util
      4.00            +0.0%       4.00            +0.0%       4.00        fxmark.ssd_f2fs_dbench_client_4_bufferedio.ncpu
     60.18            +0.0%      60.19            +0.0%      60.18        fxmark.ssd_f2fs_dbench_client_4_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_4_bufferedio.secs
      1.04 ±  2%     -62.0%       0.40 ± 13%      +3.1%       1.08        fxmark.ssd_f2fs_dbench_client_4_bufferedio.softirq_sec
      1.75           -59.9%       0.70 ± 13%      +3.1%       1.80        fxmark.ssd_f2fs_dbench_client_4_bufferedio.softirq_util
     36.84           -72.5%      10.13            -0.0%      36.82        fxmark.ssd_f2fs_dbench_client_4_bufferedio.sys_sec
     61.70           -71.0%      17.90            -0.1%      61.63        fxmark.ssd_f2fs_dbench_client_4_bufferedio.sys_util
     14.32           -71.2%       4.12 ±  2%      +0.8%      14.44        fxmark.ssd_f2fs_dbench_client_4_bufferedio.user_sec
     23.99           -69.6%       7.28 ±  2%      +0.7%      24.16        fxmark.ssd_f2fs_dbench_client_4_bufferedio.user_util
    573.42           -66.0%     194.68            -0.6%     570.11        fxmark.ssd_f2fs_dbench_client_4_bufferedio.works/sec
      0.10 ±  5%      +0.0%       0.10 ±  5%      -3.2%       0.09 ±  4%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.idle_sec
      0.16 ±  5%      -0.0%       0.16 ±  5%      -3.2%       0.15 ±  4%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.idle_util
      0.04 ± 35%     +13.0%       0.04 ± 21%      +4.3%       0.04 ± 31%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.iowait_sec
      0.06 ± 35%     +13.0%       0.07 ± 21%      +4.3%       0.07 ± 31%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.iowait_util
      4.20           -12.7%       3.67 ± 13%      -3.3%       4.06 ± 10%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.irq_sec
      6.94           -12.7%       6.06 ± 14%      -3.3%       6.71 ±  9%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.irq_util
     54.00            +0.0%      54.00            +0.0%      54.00        fxmark.ssd_f2fs_dbench_client_54_bufferedio.ncpu
     60.48            +0.0%      60.51            +0.0%      60.50        fxmark.ssd_f2fs_dbench_client_54_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_54_bufferedio.secs
      0.98 ±  2%     -13.9%       0.85 ±  2%      +1.8%       1.00 ±  3%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.softirq_sec
      1.63 ±  2%     -13.9%       1.40 ±  2%      +1.8%       1.66 ±  3%  fxmark.ssd_f2fs_dbench_client_54_bufferedio.softirq_util
     39.86            +0.5%      40.04            +0.5%      40.06        fxmark.ssd_f2fs_dbench_client_54_bufferedio.sys_sec
     65.92            +0.4%      66.21            +0.5%      66.23        fxmark.ssd_f2fs_dbench_client_54_bufferedio.sys_util
     15.29            +3.2%      15.78 ±  2%      -0.4%      15.23        fxmark.ssd_f2fs_dbench_client_54_bufferedio.user_sec
     25.28            +3.2%      26.10 ±  2%      -0.4%      25.18        fxmark.ssd_f2fs_dbench_client_54_bufferedio.user_util
    513.26 ±  2%      +2.5%     526.05 ±  3%      -1.8%     504.04        fxmark.ssd_f2fs_dbench_client_54_bufferedio.works/sec
      4.64           -10.1%       4.17 ± 11%      -2.9%       4.50 ±  8%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.irq_sec
      7.67           -10.1%       6.89 ± 11%      -3.0%       7.44 ±  8%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.irq_util
     72.00            +0.0%      72.00            +0.0%      72.00        fxmark.ssd_f2fs_dbench_client_72_bufferedio.ncpu
     60.57            +0.0%      60.58            +0.0%      60.58        fxmark.ssd_f2fs_dbench_client_72_bufferedio.real_sec
     50.00            +0.0%      50.00            +0.0%      50.00        fxmark.ssd_f2fs_dbench_client_72_bufferedio.secs
      0.93 ±  2%     -12.4%       0.81            +3.4%       0.96 ±  2%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.softirq_sec
      1.53 ±  2%     -12.4%       1.34            +3.3%       1.59 ±  2%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.softirq_util
     39.66            +0.0%      39.68            +0.1%      39.72        fxmark.ssd_f2fs_dbench_client_72_bufferedio.sys_sec
     65.56            +0.0%      65.59            +0.0%      65.58        fxmark.ssd_f2fs_dbench_client_72_bufferedio.sys_util
     15.26            +3.8%      15.84 ±  2%      +0.7%      15.38 ±  2%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.user_sec
     25.23            +3.7%      26.18 ±  2%      +0.6%      25.39 ±  2%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.user_util
    513.10 ±  4%      +3.9%     533.07 ±  3%      -0.7%     509.73 ±  5%  fxmark.ssd_f2fs_dbench_client_72_bufferedio.works/sec
    569.43            +0.4%     571.45          -100.0%       0.00        fxmark.time.elapsed_time
    569.43            +0.4%     571.45          -100.0%       0.00        fxmark.time.elapsed_time.max
    105492            -0.0%     105466          -100.0%       0.00        fxmark.time.file_system_inputs
 1.175e+08           -20.9%   92902262          -100.0%       0.00        fxmark.time.file_system_outputs
   1890674           -57.6%     801366 ±  3%    -100.0%       0.00        fxmark.time.involuntary_context_switches
     29.00            +0.0%      29.00          -100.0%       0.00        fxmark.time.major_page_faults
     15361            +0.1%      15376          -100.0%       0.00        fxmark.time.maximum_resident_set_size
    186587            +0.0%     186650          -100.0%       0.00        fxmark.time.minor_page_faults
      4096            +0.0%       4096          -100.0%       0.00        fxmark.time.page_size
     61.00           -22.4%      47.33          -100.0%       0.00        fxmark.time.percent_of_cpu_this_job_got
    252.35           -21.8%     197.33          -100.0%       0.00        fxmark.time.system_time
     97.27           -22.3%      75.58          -100.0%       0.00        fxmark.time.user_time
   1417786            -3.5%    1367858          -100.0%       0.00        fxmark.time.voluntary_context_switches
 1.298e+08           +68.8%  2.191e+08 ±  2%      -0.2%  1.296e+08        cpuidle..time
    787797           +18.6%     934538 ± 14%      +0.3%     790168 ±  5%  cpuidle..usage
    651.80            +0.5%     655.31            +0.4%     654.08        uptime.boot
     11.59 ± 15%     +14.3%      13.25 ± 19%     +19.4%      13.84 ± 20%  uptime.idle
     78.48 ±  2%      +2.3%      80.30 ±  3%      +2.9%      80.74 ±  3%  boot-time.boot
     17.01            +0.5%      17.09            +0.3%      17.05        boot-time.dhcp
     11.01 ± 16%     +15.2%      12.68 ± 20%     +20.4%      13.26 ± 20%  boot-time.idle
      0.13 ±  2%      +1.4%       0.13 ±  3%      +2.8%       0.13 ±  4%  iostat.cpu.idle
     22.60           +72.8%      39.06 ±  2%      -0.1%      22.56        iostat.cpu.iowait
     55.58           -22.2%      43.24            -0.2%      55.48        iostat.cpu.system
     21.69           -19.0%      17.57            +0.6%      21.82        iostat.cpu.user
      0.10            -0.0        0.10            -0.0        0.10        mpstat.cpu.all.idle%
     22.68           +16.5       39.20 ±  2%      -0.0       22.65        mpstat.cpu.all.iowait%
      7.34            -0.9        6.43 ± 12%      -0.2        7.14 ±  8%  mpstat.cpu.all.irq%
      1.22            -0.4        0.84            +0.0        1.27 ±  2%  mpstat.cpu.all.soft%
     47.15           -11.1       36.06            +0.1       47.22        mpstat.cpu.all.sys%
     21.50            -4.1       17.36            +0.1       21.63        mpstat.cpu.all.usr%
      1726           -19.2%       1394            +0.0%       1727        turbostat.Avg_MHz
     78.49           -15.1       63.38            +0.0       78.51        turbostat.Busy%
      2200            +0.0%       2200            +0.0%       2200        turbostat.Bzy_MHz
    358924            +7.4%     385554 ± 10%      +4.9%     376655 ±  6%  turbostat.C1
      3.90 ±  5%      +6.7       10.61 ±  6%      +0.6        4.48 ± 14%  turbostat.C1%
    203739           +42.9%     291057 ±  8%      -7.1%     189209 ±  8%  turbostat.C1E
     17.53            +8.4       25.98 ±  6%      -0.6       16.94 ±  5%  turbostat.C1E%
     39.00            +0.0%      39.00            -1.0%      38.60        turbostat.CoreTmp
   3039624           -26.7%    2226778 ±  9%      +0.2%    3044933 ±  5%  turbostat.IRQ
     42.83            +0.0%      42.83            -1.7%      42.10        turbostat.PkgTmp
      2200            +0.0%       2200            +0.0%       2200        turbostat.TSC_MHz
    569.43            +0.4%     571.45          -100.0%       0.00        time.elapsed_time
    569.43            +0.4%     571.45          -100.0%       0.00        time.elapsed_time.max
    105492            -0.0%     105466          -100.0%       0.00        time.file_system_inputs
 1.175e+08           -20.9%   92902262          -100.0%       0.00        time.file_system_outputs
   1890674           -57.6%     801366 ±  3%    -100.0%       0.00        time.involuntary_context_switches
     29.00            +0.0%      29.00          -100.0%       0.00        time.major_page_faults
     15361            +0.1%      15376          -100.0%       0.00        time.maximum_resident_set_size
    186587            +0.0%     186650          -100.0%       0.00        time.minor_page_faults
      4096            +0.0%       4096          -100.0%       0.00        time.page_size
     61.00           -22.4%      47.33          -100.0%       0.00        time.percent_of_cpu_this_job_got
    252.35           -21.8%     197.33          -100.0%       0.00        time.system_time
     97.27           -22.3%      75.58          -100.0%       0.00        time.user_time
   1417786            -3.5%    1367858          -100.0%       0.00        time.voluntary_context_switches
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.cpu.id
     55.00           -22.4%      42.67 ±  2%      -0.2%      54.90        vmstat.cpu.sy
     21.00           -19.0%      17.00            +1.4%      21.30 ±  2%  vmstat.cpu.us
     22.00           +75.0%      38.50 ±  2%      +0.5%      22.10        vmstat.cpu.wa
    120.33            -1.0%     119.17            -0.2%     120.10        vmstat.io.bi
     26313           -20.7%      20853            -0.7%      26138        vmstat.io.bo
    712.50 ± 58%     -21.4%     559.83 ± 56%     +37.8%     981.70 ± 34%  vmstat.memory.buff
   3067391            -0.1%    3063819            -0.0%    3066780        vmstat.memory.cache
  62063799            +0.0%   62067535            +0.0%   62064942        vmstat.memory.free
      0.00         +2e+102%       2.00          -100.0%       0.00        vmstat.procs.b
     18.00           -13.0%      15.67 ±  3%      +0.0%      18.00        vmstat.procs.r
     13423           -34.5%       8795            +0.1%      13438        vmstat.system.cs
      5309           -26.9%       3880 ±  9%      +0.1%       5317 ±  5%  vmstat.system.in
    829819           -43.9%     465519            -0.5%     825936        softirqs.BLOCK
    829819           -43.9%     465519            -0.5%     825936        softirqs.CPU0.BLOCK
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.CPU0.HI
     33585 ± 28%      -7.9%      30927 ± 39%    +112.4%      71341 ± 53%  softirqs.CPU0.NET_RX
     64.50            +2.1%      65.83            +1.1%      65.20        softirqs.CPU0.NET_TX
   1416557           -20.6%    1124482            +1.2%    1433330        softirqs.CPU0.RCU
     74.00            +0.0%      74.00            +0.0%      74.00        softirqs.CPU0.TASKLET
     91043 ±  2%      +9.5%      99696            +4.3%      94924 ±  3%  softirqs.CPU0.TIMER
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.HI
     33585 ± 28%      -7.9%      30927 ± 39%    +112.4%      71341 ± 53%  softirqs.NET_RX
     64.50            +2.1%      65.83            +1.1%      65.20        softirqs.NET_TX
   1416557           -20.6%    1124482            +1.2%    1433330        softirqs.RCU
     74.00            +0.0%      74.00            +0.0%      74.00        softirqs.TASKLET
     91043 ±  2%      +9.5%      99696            +4.3%      94924 ±  3%  softirqs.TIMER
     73584            -0.5%      73241            +0.2%      73699        meminfo.Active
      1233            -0.6%       1225 ±  3%      +1.0%       1245 ±  4%  meminfo.Active(anon)
     72350            -0.5%      72015            +0.1%      72454        meminfo.Active(file)
    196210            -0.3%     195618            -0.4%     195414        meminfo.AnonHugePages
    251139            -0.4%     250241            -0.1%     250965        meminfo.AnonPages
    755.33 ± 50%      +6.7%     805.83 ± 31%     -24.4%     570.90 ± 43%  meminfo.Buffers
   2949061            -0.1%    2946864            +0.0%    2949891        meminfo.Cached
  32769256            +0.0%   32769256            +0.0%   32769256        meminfo.CommitLimit
    347994 ±  2%      +1.4%     352992            +0.0%     348036 ±  2%  meminfo.Committed_AS
  64312661            +0.5%   64662186            +0.9%   64906854        meminfo.DirectMap1G
   4480299 ± 10%      -7.7%    4136595 ± 11%     -13.2%    3889745 ± 14%  meminfo.DirectMap2M
     88502 ±  6%      -6.6%      82681 ±  4%      -4.1%      84863 ±  5%  meminfo.DirectMap4k
    371088            -0.4%     369553            +0.1%     371618        meminfo.Dirty
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    580173            -0.5%     576994            -0.0%     580131        meminfo.Inactive
    267360            -0.6%     265833            -0.1%     267158        meminfo.Inactive(anon)
    312812            -0.5%     311160            +0.1%     312973        meminfo.Inactive(file)
     70655            -1.0%      69956            -0.0%      70634        meminfo.KReclaimable
      3564            -0.1%       3561            -0.3%       3552        meminfo.KernelStack
     37792            -0.8%      37506            -0.1%      37759        meminfo.Mapped
  62015324            +0.0%   62016556            +0.0%   62015790        meminfo.MemAvailable
  62112907            +0.0%   62116186            +0.0%   62112973        meminfo.MemFree
  65538512            +0.0%   65538512            +0.0%   65538512        meminfo.MemTotal
   3425603            -0.1%    3422324            -0.0%    3425537        meminfo.Memused
      1414 ± 24%     +11.3%       1575 ± 27%     +28.5%       1817 ± 25%  meminfo.Mlocked
      4252            -0.3%       4239            -0.8%       4219        meminfo.PageTables
    475.67            +0.4%     477.67            +0.8%     479.40        meminfo.Percpu
     70655            -1.0%      69956            -0.0%      70634        meminfo.SReclaimable
     24359            -0.0%      24355            +0.1%      24378        meminfo.SUnreclaim
     17533            -3.1%      16988 ±  2%      +0.8%      17670        meminfo.Shmem
     95015            -0.7%      94312            -0.0%      95013        meminfo.Slab
   2547305            +0.0%    2547717            +0.0%    2547612        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
     29213            +0.0%      29216            -0.0%      29210        meminfo.VmallocUsed
     74.33 ± 40%     +42.2%     105.67 ± 29%     -17.7%      61.20 ± 33%  meminfo.Writeback
   4640139            -0.1%    4636390            -0.1%    4633880        meminfo.max_used_kB
   1309719            -6.5%    1224858 ± 16%      -3.9%    1258138 ± 13%  interrupts.0:XT-PIC.timer
     22.67 ±  3%      +3.7%      23.50 ± 12%      -3.8%      21.80 ±  4%  interrupts.19:PCI-MSI.425984-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.20:PCI-MSI.428032-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.21:PCI-MSI.430080-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.22:PCI-MSI.1572864-edge.eth0
     53923 ± 30%      +1.0%      54437 ± 39%    +112.7%     114706 ± 52%  interrupts.23:PCI-MSI.1572865-edge.eth0-rx-0
      1330 ±  2%      +0.4%       1336            +1.5%       1351 ±  2%  interrupts.24:PCI-MSI.1572866-edge.eth0-tx-0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.26:PCI-MSI.2097153-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.27:PCI-MSI.2097154-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.29:PCI-MSI.393216-edge.mei_me
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.33:PCI-MSI.16384-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.34:PCI-MSI.18432-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.35:PCI-MSI.20480-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.36:PCI-MSI.22528-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.37:PCI-MSI.24576-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.38:PCI-MSI.26624-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.39:PCI-MSI.28672-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.40:PCI-MSI.30720-edge.ioat-msix
   1663523           -43.8%     935354            -0.5%    1655460        interrupts.41:PCI-MSI.229376-edge.ahci[0000:00:0e.0]
   1309719            -6.5%    1224858 ± 16%      -3.9%    1258138 ± 13%  interrupts.CPU0.0:XT-PIC.timer
     22.67 ±  3%      +3.7%      23.50 ± 12%      -3.8%      21.80 ±  4%  interrupts.CPU0.19:PCI-MSI.425984-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.20:PCI-MSI.428032-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.21:PCI-MSI.430080-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.22:PCI-MSI.1572864-edge.eth0
     53923 ± 30%      +1.0%      54437 ± 39%    +112.7%     114706 ± 52%  interrupts.CPU0.23:PCI-MSI.1572865-edge.eth0-rx-0
      1330 ±  2%      +0.4%       1336            +1.5%       1351 ±  2%  interrupts.CPU0.24:PCI-MSI.1572866-edge.eth0-tx-0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.26:PCI-MSI.2097153-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.27:PCI-MSI.2097154-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.29:PCI-MSI.393216-edge.mei_me
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.33:PCI-MSI.16384-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.34:PCI-MSI.18432-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.35:PCI-MSI.20480-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.36:PCI-MSI.22528-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.37:PCI-MSI.24576-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.38:PCI-MSI.26624-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.39:PCI-MSI.28672-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.40:PCI-MSI.30720-edge.ioat-msix
   1663523           -43.8%     935354            -0.5%    1655460        interrupts.CPU0.41:PCI-MSI.229376-edge.ahci[0000:00:0e.0]
     26.50 ±  6%     -22.0%      20.67 ± 11%      -2.6%      25.80 ±  8%  interrupts.CPU0.IWI:IRQ_work_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU0.MCP:Machine_check_polls
      6593 ± 38%      -2.0%       6462 ± 41%     +33.0%       8767 ± 31%  interrupts.CPU0.NMI:Non-maskable_interrupts
      6593 ± 38%      -2.0%       6462 ± 41%     +33.0%       8767 ± 31%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     26.50 ±  6%     -22.0%      20.67 ± 11%      -2.6%      25.80 ±  8%  interrupts.IWI:IRQ_work_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.MCP:Machine_check_polls
      6593 ± 38%      -2.0%       6462 ± 41%     +33.0%       8767 ± 31%  interrupts.NMI:Non-maskable_interrupts
      6593 ± 38%      -2.0%       6462 ± 41%     +33.0%       8767 ± 31%  interrupts.PMI:Performance_monitoring_interrupts
      3.86            -1.1%       3.81            -0.0%       3.85        perf-stat.i.MPKI
 3.895e+08           -20.3%  3.106e+08            -0.3%  3.884e+08        perf-stat.i.branch-instructions
      1.86            -0.0        1.86            -0.0        1.86        perf-stat.i.branch-miss-rate%
   6018793           -20.4%    4791460            +0.1%    6026742        perf-stat.i.branch-misses
     44.43            +1.2       45.67            -0.3       44.17        perf-stat.i.cache-miss-rate%
   5076824           -11.4%    4495612            -0.4%    5056242        perf-stat.i.cache-misses
   8645920           -19.5%    6960538            +0.1%    8655668        perf-stat.i.cache-references
     13446           -34.7%       8787            +0.2%      13468        perf-stat.i.context-switches
      1.47            -0.5%       1.46 ±  7%      -3.0%       1.42 ±  5%  perf-stat.i.cpi
      1000            -0.0%       1000            -0.0%       1000        perf-stat.i.cpu-clock
 1.718e+09           -19.3%  1.386e+09            +0.0%  1.719e+09        perf-stat.i.cpu-cycles
     23297 ±  8%      -3.4%      22510 ± 15%      -0.7%      23124 ± 13%  perf-stat.i.cycles-between-cache-misses
      0.13 ±  3%      +0.0        0.13 ±  4%      -0.0        0.13 ±  5%  perf-stat.i.dTLB-load-miss-rate%
    414520 ±  5%     -21.4%     325966 ±  6%      -3.4%     400244 ±  6%  perf-stat.i.dTLB-load-misses
 4.994e+08           -20.9%  3.951e+08            -0.5%   4.97e+08        perf-stat.i.dTLB-loads
      0.02            +0.0        0.02 ±  4%      -0.0        0.02 ±  3%  perf-stat.i.dTLB-store-miss-rate%
     30613           -26.8%      22395 ±  6%      -4.2%      29339 ±  5%  perf-stat.i.dTLB-store-misses
 2.937e+08           -21.5%  2.306e+08            -0.5%  2.923e+08        perf-stat.i.dTLB-stores
 1.913e+09           -20.4%  1.523e+09            -0.3%  1.907e+09        perf-stat.i.instructions
      0.97            -2.8%       0.94 ±  3%      +0.1%       0.97        perf-stat.i.ipc
      0.06            -0.3%       0.06            -0.0%       0.06        perf-stat.i.major-faults
      1.72           -19.3%       1.39            +0.0%       1.72        perf-stat.i.metric.GHz
     60.16           -20.6%      47.79 ±  5%      -2.8%      58.47 ±  3%  perf-stat.i.metric.K/sec
      1191           -20.8%     943.22            -0.4%       1186        perf-stat.i.metric.M/sec
      1534            +0.5%       1541            -0.1%       1532        perf-stat.i.minor-faults
      1534            +0.5%       1541            -0.1%       1532        perf-stat.i.page-faults
      1000            -0.0%       1000            -0.0%       1000        perf-stat.i.task-clock
      4.52            +1.1%       4.57            +0.4%       4.54        perf-stat.overall.MPKI
      1.55            -0.0        1.54            +0.0        1.55        perf-stat.overall.branch-miss-rate%
     58.73            +5.9       64.59            -0.3       58.42        perf-stat.overall.cache-miss-rate%
      0.90            +1.3%       0.91 ±  2%      +0.4%       0.90        perf-stat.overall.cpi
    338.44            -8.9%     308.37 ±  2%      +0.5%     340.00        perf-stat.overall.cycles-between-cache-misses
      0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.08 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.01            -0.0        0.01 ±  6%      -0.0        0.01 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      1.11            -1.2%       1.10 ±  2%      -0.3%       1.11        perf-stat.overall.ipc
 3.892e+08           -20.3%  3.104e+08            -0.3%   3.88e+08        perf-stat.ps.branch-instructions
   6013633           -20.4%    4788028            +0.1%    6019963        perf-stat.ps.branch-misses
   5072419           -11.5%    4491286            -0.4%    5050443        perf-stat.ps.cache-misses
   8637647           -19.5%    6953483            +0.1%    8645195        perf-stat.ps.cache-references
     13433           -34.6%       8778            +0.1%      13452        perf-stat.ps.context-switches
    999.30            -0.0%     999.18            -0.0%     999.09        perf-stat.ps.cpu-clock
 1.717e+09           -19.3%  1.385e+09            +0.0%  1.717e+09        perf-stat.ps.cpu-cycles
    414159 ±  5%     -21.4%     325648 ±  6%      -3.5%     399791 ±  7%  perf-stat.ps.dTLB-load-misses
  4.99e+08           -20.9%  3.947e+08            -0.5%  4.964e+08        perf-stat.ps.dTLB-loads
     30589           -26.8%      22377 ±  6%      -4.2%      29308 ±  5%  perf-stat.ps.dTLB-store-misses
 2.935e+08           -21.5%  2.303e+08            -0.5%   2.92e+08        perf-stat.ps.dTLB-stores
 1.911e+09           -20.4%  1.522e+09            -0.3%  1.905e+09        perf-stat.ps.instructions
      0.06            -0.3%       0.06            -0.0%       0.06        perf-stat.ps.major-faults
      1534            +0.4%       1540            -0.2%       1531        perf-stat.ps.minor-faults
      1534            +0.4%       1540            -0.2%       1531        perf-stat.ps.page-faults
    999.30            -0.0%     999.18            -0.0%     999.09        perf-stat.ps.task-clock
  1.09e+12           -20.1%  8.705e+11            -0.3%  1.087e+12        perf-stat.total.instructions
     30.83 ±  9%      -9.2%      28.00 ±  7%      -5.6%      29.10 ±  7%  proc-vmstat.direct_map_level2_splits
      1.67 ± 28%     -20.0%       1.33 ± 35%     -34.0%       1.10 ± 48%  proc-vmstat.direct_map_level3_splits
      7.00            +0.0%       7.00            +0.0%       7.00        proc-vmstat.drop_pagecache
      7.00            +0.0%       7.00            +0.0%       7.00        proc-vmstat.drop_slab
    304.17 ±  2%      -0.3%     303.33 ±  3%      +3.8%     315.60 ±  2%  proc-vmstat.nr_active_anon
     17896            -0.4%      17826            -0.0%      17893        proc-vmstat.nr_active_file
     62785            -0.4%      62553            -0.1%      62731        proc-vmstat.nr_anon_pages
     95.33            -0.2%      95.17            -0.5%      94.90        proc-vmstat.nr_anon_transparent_hugepages
  14701469           -20.9%   11625477            -0.6%   14615163        proc-vmstat.nr_dirtied
     91854            -0.5%      91432            -0.1%      91744        proc-vmstat.nr_dirty
   1548753            +0.0%    1548765            -0.0%    1548739        proc-vmstat.nr_dirty_background_threshold
   3101294            +0.0%    3101319            -0.0%    3101265        proc-vmstat.nr_dirty_threshold
    736493            -0.1%     735909            -0.0%     736417        proc-vmstat.nr_file_pages
  15529442            +0.0%   15530113            +0.0%   15529475        proc-vmstat.nr_free_pages
     66839            -0.6%      66450            -0.1%      66774        proc-vmstat.nr_inactive_anon
     77435            -0.6%      76958            -0.2%      77262        proc-vmstat.nr_inactive_file
      3561            -0.1%       3558            -0.3%       3548        proc-vmstat.nr_kernel_stack
      9468            -0.8%       9395            -0.2%       9449        proc-vmstat.nr_mapped
    354.33 ± 24%     +11.3%     394.50 ± 27%     +28.3%     454.70 ± 24%  proc-vmstat.nr_mlock
      1061            -0.3%       1057            -0.8%       1052        proc-vmstat.nr_page_table_pages
      4381            -3.1%       4246 ±  2%      +0.9%       4420        proc-vmstat.nr_shmem
     17652            -1.0%      17472            -0.0%      17646        proc-vmstat.nr_slab_reclaimable
      6085            -0.0%       6084            +0.1%       6090        proc-vmstat.nr_slab_unreclaimable
    636826            +0.0%     636929            +0.0%     636902        proc-vmstat.nr_unevictable
     18.83 ± 39%      -8.0%      17.33 ± 36%      -7.6%      17.40 ± 34%  proc-vmstat.nr_writeback
   3770510           -20.5%    2995998            -0.6%    3747041        proc-vmstat.nr_written
    304.17 ±  2%      -0.3%     303.33 ±  3%      +3.8%     315.60 ±  2%  proc-vmstat.nr_zone_active_anon
     17896            -0.4%      17826            -0.0%      17893        proc-vmstat.nr_zone_active_file
     66839            -0.6%      66450            -0.1%      66774        proc-vmstat.nr_zone_inactive_anon
     77435            -0.6%      76958            -0.2%      77262        proc-vmstat.nr_zone_inactive_file
    636826            +0.0%     636929            +0.0%     636902        proc-vmstat.nr_zone_unevictable
     91872            -0.5%      91448            -0.1%      91761        proc-vmstat.nr_zone_write_pending
  14185527           -19.8%   11374067            -0.6%   14105243        proc-vmstat.numa_hit
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  14185527           -19.8%   11374067            -0.6%   14105243        proc-vmstat.numa_local
    689034           -19.6%     553980            -0.5%     685578        proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
  14193405           -19.8%   11381945            -0.6%   14113121        proc-vmstat.pgalloc_normal
    758967           -21.5%     595725            -0.7%     754011        proc-vmstat.pgdeactivate
    909347            +1.1%     918936            -0.1%     908304        proc-vmstat.pgfault
  14213872           -19.8%   11402055            -0.6%   14132605        proc-vmstat.pgfree
     69154            -0.7%      68683            -0.3%      68934        proc-vmstat.pgpgin
  15082048           -20.5%   11983998            -0.6%   14988182        proc-vmstat.pgpgout
    112513            +1.1%     113741            +0.5%     113036        proc-vmstat.pgreuse
    783351           -22.4%     607984            -0.7%     778167        proc-vmstat.pgrotated
   1616179 ±  4%     -55.7%     715381 ± 24%      -3.1%    1565321 ±  4%  proc-vmstat.slabs_scanned
     65.33 ±  3%      -1.0%      64.67 ±  2%      -2.0%      64.00        proc-vmstat.thp_collapse_alloc
      1.67 ±141%     -50.0%       0.83 ±223%     -70.0%       0.50 ±300%  proc-vmstat.thp_deferred_split_page
      0.83 ±107%     -20.0%       0.67 ±141%     -28.0%       0.60 ±152%  proc-vmstat.thp_fault_alloc
      1.33 ±141%     -50.0%       0.67 ±223%     -70.0%       0.40 ±300%  proc-vmstat.thp_split_page
      1.67 ±141%     -50.0%       0.83 ±223%     -70.0%       0.50 ±300%  proc-vmstat.thp_split_pmd
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    151.00            +0.1%     151.17            -1.1%     149.30 ±  2%  proc-vmstat.unevictable_pgs_culled
    586.00            +0.0%     586.00            +0.0%     586.00        proc-vmstat.unevictable_pgs_mlocked
      9.00            +0.0%       9.00            +0.0%       9.00        slabinfo.DCCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCP.active_slabs
      9.00            +0.0%       9.00            +0.0%       9.00        slabinfo.DCCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCP.num_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.DCCPv6.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCPv6.active_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.DCCPv6.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCPv6.num_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.RAW.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.RAW.active_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.RAW.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.RAW.num_slabs
     13.00            +0.0%      13.00            +0.0%      13.00        slabinfo.RAWv6.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.RAWv6.active_slabs
     13.00            +0.0%      13.00            +0.0%      13.00        slabinfo.RAWv6.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.RAWv6.num_slabs
     14.00            +0.0%      14.00            +0.0%      14.00        slabinfo.TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.TCP.active_slabs
     14.00            +0.0%      14.00            +0.0%      14.00        slabinfo.TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.TCP.num_slabs
     13.00            +0.0%      13.00            +0.0%      13.00        slabinfo.TCPv6.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.TCPv6.active_slabs
     13.00            +0.0%      13.00            +0.0%      13.00        slabinfo.TCPv6.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.TCPv6.num_slabs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.UDPv6.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.UDPv6.active_slabs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.UDPv6.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.UDPv6.num_slabs
     75.00            +0.0%      75.00            -0.3%      74.80        slabinfo.UNIX.active_objs
      5.00            +0.0%       5.00            -2.0%       4.90 ±  6%  slabinfo.UNIX.active_slabs
     75.00            +0.0%      75.00            -0.3%      74.80        slabinfo.UNIX.num_objs
      5.00            +0.0%       5.00            -2.0%       4.90 ±  6%  slabinfo.UNIX.num_slabs
      1488            +0.2%       1492            -0.0%       1488        slabinfo.anon_vma.active_objs
     35.67            +0.0%      35.67 ±  2%      +1.2%      36.10        slabinfo.anon_vma.active_slabs
      1665            -0.3%       1659            +1.0%       1681        slabinfo.anon_vma.num_objs
     35.67            +0.0%      35.67 ±  2%      +1.2%      36.10        slabinfo.anon_vma.num_slabs
      2514            +0.0%       2514            -0.0%       2514        slabinfo.anon_vma_chain.active_objs
     46.00            -1.1%      45.50            -0.2%      45.90        slabinfo.anon_vma_chain.active_slabs
      2962            -0.7%       2942            +0.0%       2963        slabinfo.anon_vma_chain.num_objs
     46.00            -1.1%      45.50            -0.2%      45.90        slabinfo.anon_vma_chain.num_slabs
     10.00            +0.0%      10.00            +0.0%      10.00        slabinfo.bdev_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.bdev_cache.active_slabs
     10.00            +0.0%      10.00            +0.0%      10.00        slabinfo.bdev_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.bdev_cache.num_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.bio-120.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.bio-120.active_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.bio-120.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.bio-120.num_slabs
    268.00            -0.9%     265.67 ±  3%      -0.2%     267.40        slabinfo.bio-184.active_objs
     12.50 ±  4%      +1.3%      12.67 ±  3%      -1.6%      12.30 ±  3%  slabinfo.bio-184.active_slabs
    271.33 ±  2%      +0.1%     271.67 ±  3%      +0.5%     272.70 ±  3%  slabinfo.bio-184.num_objs
     12.50 ±  4%      +1.3%      12.67 ±  3%      -1.6%      12.30 ±  3%  slabinfo.bio-184.num_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.bio-240.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.bio-240.active_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.bio-240.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.bio-240.num_slabs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.bio-248.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.bio-248.active_slabs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.bio-248.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.bio-248.num_slabs
     31.00            +0.0%      31.00            +0.0%      31.00        slabinfo.biovec-128.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.biovec-128.active_slabs
     31.00            +0.0%      31.00            +0.0%      31.00        slabinfo.biovec-128.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.biovec-128.num_slabs
     14.67 ±  3%     +37.5%      20.17            -5.2%      13.90 ± 14%  slabinfo.biovec-64.active_objs
      1.00          +100.0%       2.00            +0.0%       1.00        slabinfo.biovec-64.active_slabs
     14.67 ±  3%     +37.5%      20.17            -5.2%      13.90 ± 14%  slabinfo.biovec-64.num_objs
      1.00          +100.0%       2.00            +0.0%       1.00        slabinfo.biovec-64.num_slabs
     70.67            +1.4%      71.67            +0.6%      71.10        slabinfo.biovec-max.active_objs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.biovec-max.active_slabs
    100.83            +0.0%     100.83            -0.5%     100.30        slabinfo.biovec-max.num_objs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.biovec-max.num_slabs
    373.17 ± 16%      -4.4%     356.83 ± 13%      -6.0%     350.90 ± 15%  slabinfo.buffer_head.active_objs
     13.67 ± 10%      -2.4%      13.33 ±  9%      -3.4%      13.20 ±  9%  slabinfo.buffer_head.active_slabs
    557.50 ± 10%      -3.0%     541.00 ±  9%      -4.0%     535.10 ±  9%  slabinfo.buffer_head.num_objs
     13.67 ± 10%      -2.4%      13.33 ±  9%      -3.4%      13.20 ±  9%  slabinfo.buffer_head.num_slabs
    398.17            +1.4%     403.67            +1.2%     403.00        slabinfo.cred_jar.active_objs
     20.00            -1.7%      19.67 ±  2%      +0.0%      20.00        slabinfo.cred_jar.active_slabs
    424.17            -0.4%     422.50 ±  2%      +0.7%     427.20        slabinfo.cred_jar.num_objs
     20.00            -1.7%      19.67 ±  2%      +0.0%      20.00        slabinfo.cred_jar.num_slabs
     19.00            +0.0%      19.00            +0.0%      19.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     19.00            +0.0%      19.00            +0.0%      19.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
     65192            +0.0%      65207            -0.0%      65176        slabinfo.dentry.active_objs
      3175            +0.1%       3177            +0.1%       3177        slabinfo.dentry.active_slabs
     66696            +0.1%      66739            +0.1%      66733        slabinfo.dentry.num_objs
      3175            +0.1%       3177            +0.1%       3177        slabinfo.dentry.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     99.50 ± 12%      +6.7%     106.17 ± 44%      +1.8%     101.30 ± 31%  slabinfo.dmaengine-unmap-16.active_objs
      4.17 ± 16%      +8.0%       4.50 ± 57%     +15.2%       4.80 ± 49%  slabinfo.dmaengine-unmap-16.active_slabs
     99.50 ± 12%      +6.7%     106.17 ± 44%     +13.7%     113.10 ± 43%  slabinfo.dmaengine-unmap-16.num_objs
      4.17 ± 16%      +8.0%       4.50 ± 57%     +15.2%       4.80 ± 49%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.ep_head.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ep_head.active_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.ep_head.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ep_head.num_slabs
    283.00            +0.0%     283.00            +0.0%     283.00        slabinfo.ext4_extent_status.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.ext4_extent_status.active_slabs
    283.00            +0.0%     283.00            +0.0%     283.00        slabinfo.ext4_extent_status.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.ext4_extent_status.num_slabs
      1305            +2.1%       1332            -0.1%       1304        slabinfo.ext4_fc_dentry_update.active_objs
     27.83            +2.4%      28.50            -0.1%      27.80        slabinfo.ext4_fc_dentry_update.active_slabs
      1441            +2.3%       1474            -0.0%       1441        slabinfo.ext4_fc_dentry_update.num_objs
     27.83            +2.4%      28.50            -0.1%      27.80        slabinfo.ext4_fc_dentry_update.num_slabs
    298.50 ± 14%     +10.2%     328.83            +7.2%     320.00 ±  8%  slabinfo.ext4_io_end.active_objs
      7.67 ±  6%      +4.3%       8.00            +3.0%       7.90 ±  3%  slabinfo.ext4_io_end.active_slabs
    522.00 ±  8%      +5.3%     549.67            +4.3%     544.30 ±  4%  slabinfo.ext4_io_end.num_objs
      7.67 ±  6%      +4.3%       8.00            +3.0%       7.90 ±  3%  slabinfo.ext4_io_end.num_slabs
     55284           -18.8%      44889            +0.1%      55312        slabinfo.ext4_pending_reservation.active_objs
    433.00           -18.8%     351.50            +0.1%     433.40        slabinfo.ext4_pending_reservation.active_slabs
     55486           -18.8%      45070            +0.1%      55518        slabinfo.ext4_pending_reservation.num_objs
    433.00           -18.8%     351.50            +0.1%     433.40        slabinfo.ext4_pending_reservation.num_slabs
    249.17 ± 12%      -1.9%     244.50 ±  6%     -11.3%     221.00 ±  6%  slabinfo.f2fs_discard_cmd.active_objs
      7.17 ± 12%      +4.7%       7.50 ± 16%      -6.5%       6.70 ±  6%  slabinfo.f2fs_discard_cmd.active_slabs
    279.33 ±  9%      +2.4%     286.00 ± 13%      -9.4%     253.10 ±  5%  slabinfo.f2fs_discard_cmd.num_objs
      7.17 ± 12%      +4.7%       7.50 ± 16%      -6.5%       6.70 ±  6%  slabinfo.f2fs_discard_cmd.num_slabs
     49.83 ± 30%      -1.7%      49.00 ± 27%      -5.5%      47.10 ± 26%  slabinfo.f2fs_discard_entry.active_objs
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  slabinfo.f2fs_discard_entry.active_slabs
     49.83 ± 30%      -1.7%      49.00 ± 27%      -5.5%      47.10 ± 26%  slabinfo.f2fs_discard_entry.num_objs
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  slabinfo.f2fs_discard_entry.num_slabs
     22987           -30.8%      15910 ±  3%      -1.1%      22738        slabinfo.f2fs_free_nid.active_objs
    139.17           -29.9%      97.50 ±  3%      -1.1%     137.60        slabinfo.f2fs_free_nid.active_slabs
     23714           -29.9%      16632 ±  3%      -1.0%      23474        slabinfo.f2fs_free_nid.num_objs
    139.17           -29.9%      97.50 ±  3%      -1.1%     137.60        slabinfo.f2fs_free_nid.num_slabs
      1400            +0.3%       1405            +0.3%       1404        slabinfo.f2fs_inode_cache.active_objs
    107.67            -1.4%     106.17            +0.3%     108.00        slabinfo.f2fs_inode_cache.active_slabs
      1514            -1.4%       1494            +0.3%       1519        slabinfo.f2fs_inode_cache.num_objs
    107.67            -1.4%     106.17            +0.3%     108.00        slabinfo.f2fs_inode_cache.num_slabs
     13.00            +0.0%      13.00            +0.0%      13.00        slabinfo.f2fs_xattr_entry-8:17.active_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.f2fs_xattr_entry-8:17.active_slabs
     13.00            +0.0%      13.00            +0.0%      13.00        slabinfo.f2fs_xattr_entry-8:17.num_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.f2fs_xattr_entry-8:17.num_slabs
     18.00            +0.0%      18.00            +0.0%      18.00        slabinfo.file_lock_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.file_lock_cache.active_slabs
     18.00            +0.0%      18.00            +0.0%      18.00        slabinfo.file_lock_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.file_lock_cache.num_slabs
    245.50 ± 14%      +9.4%     268.50 ±  9%      +0.0%     245.50 ± 14%  slabinfo.file_lock_ctx.active_objs
      2.50 ± 20%     +13.3%       2.83 ± 13%      +0.0%       2.50 ± 20%  slabinfo.file_lock_ctx.active_slabs
    245.50 ± 14%      +9.4%     268.50 ±  9%      +0.0%     245.50 ± 14%  slabinfo.file_lock_ctx.num_objs
      2.50 ± 20%     +13.3%       2.83 ± 13%      +0.0%       2.50 ± 20%  slabinfo.file_lock_ctx.num_slabs
    127.33 ±  4%      -3.0%     123.50            +1.2%     128.80 ±  4%  slabinfo.files_cache.active_objs
     11.67 ±  4%      -2.9%      11.33 ±  4%      +3.7%      12.10 ±  6%  slabinfo.files_cache.active_slabs
    133.83 ±  2%      -1.4%     132.00            +2.6%     137.30 ±  4%  slabinfo.files_cache.num_objs
     11.67 ±  4%      -2.9%      11.33 ±  4%      +3.7%      12.10 ±  6%  slabinfo.files_cache.num_slabs
      1466            +0.4%       1472            -0.1%       1464        slabinfo.filp.active_objs
    102.00 ±  2%      +2.0%     104.00            +1.8%     103.80 ±  2%  slabinfo.filp.active_slabs
      1642 ±  2%      +1.7%       1670            +1.6%       1668 ±  2%  slabinfo.filp.num_objs
    102.00 ±  2%      +2.0%     104.00            +1.8%     103.80 ±  2%  slabinfo.filp.num_slabs
    357.67            +0.3%     358.67            +1.1%     361.60        slabinfo.fsnotify_mark_connector.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.fsnotify_mark_connector.active_slabs
    492.33            -0.1%     491.83            -0.0%     492.20        slabinfo.fsnotify_mark_connector.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.fsnotify_mark_connector.num_slabs
      5677            -0.0%       5677            +0.0%       5677        slabinfo.ftrace_event_field.active_objs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.ftrace_event_field.active_slabs
      5677            -0.0%       5677            +0.0%       5677        slabinfo.ftrace_event_field.num_objs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.ftrace_event_field.num_slabs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.hugetlbfs_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.hugetlbfs_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     59664            +0.0%      59674            +0.0%      59678        slabinfo.inode_cache.active_objs
      2423            -0.0%       2422            -0.1%       2422        slabinfo.inode_cache.active_slabs
     60600            -0.0%      60577            -0.1%      60565        slabinfo.inode_cache.num_objs
      2423            -0.0%       2422            -0.1%       2422        slabinfo.inode_cache.num_slabs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.ip4-frags.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip4-frags.active_slabs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.ip4-frags.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip4-frags.num_slabs
     22.00            +0.0%      22.00            +0.0%      22.00        slabinfo.ip6-frags.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip6-frags.active_slabs
     22.00            +0.0%      22.00            +0.0%      22.00        slabinfo.ip6-frags.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip6-frags.num_slabs
     73.00            +0.0%      73.00            +0.0%      73.00        slabinfo.ip_fib_alias.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip_fib_alias.active_slabs
     73.00            +0.0%      73.00            +0.0%      73.00        slabinfo.ip_fib_alias.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip_fib_alias.num_slabs
     85.00            +0.0%      85.00            +0.0%      85.00        slabinfo.ip_fib_trie.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip_fib_trie.active_slabs
     85.00            +0.0%      85.00            +0.0%      85.00        slabinfo.ip_fib_trie.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip_fib_trie.num_slabs
     24578            +0.1%      24602            +0.2%      24632        slabinfo.kernfs_node_cache.active_objs
    767.67            +0.1%     768.33            +0.2%     769.40        slabinfo.kernfs_node_cache.active_slabs
     24580            +0.1%      24602            +0.2%      24632        slabinfo.kernfs_node_cache.num_objs
    767.67            +0.1%     768.33            +0.2%     769.40        slabinfo.kernfs_node_cache.num_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.khugepaged_mm_slot.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.khugepaged_mm_slot.active_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.khugepaged_mm_slot.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.khugepaged_mm_slot.num_slabs
      1358            -0.6%       1350            -0.4%       1353        slabinfo.kmalloc-128.active_objs
     50.33            +0.7%      50.67            +1.1%      50.90 ±  2%  slabinfo.kmalloc-128.active_slabs
      1619            +0.9%       1634            +1.6%       1645 ±  2%  slabinfo.kmalloc-128.num_objs
     50.33            +0.7%      50.67            +1.1%      50.90 ±  2%  slabinfo.kmalloc-128.num_slabs
      4591            +0.0%       4593            +0.1%       4596        slabinfo.kmalloc-16.active_objs
     18.00            +0.0%      18.00            +0.0%      18.00        slabinfo.kmalloc-16.active_slabs
      4608            +0.0%       4608            +0.0%       4608        slabinfo.kmalloc-16.num_objs
     18.00            +0.0%      18.00            +0.0%      18.00        slabinfo.kmalloc-16.num_slabs
      1857            +0.2%       1860            +1.0%       1874        slabinfo.kmalloc-192.active_objs
     94.83            +0.2%      95.00            +2.0%      96.70        slabinfo.kmalloc-192.active_slabs
      1999            +0.2%       2003            +2.1%       2042        slabinfo.kmalloc-192.num_objs
     94.83            +0.2%      95.00            +2.0%      96.70        slabinfo.kmalloc-192.num_slabs
    825.00            +0.3%     827.33            +0.4%     828.40        slabinfo.kmalloc-1k.active_objs
    103.00            +0.2%     103.17            +0.3%     103.30        slabinfo.kmalloc-1k.active_slabs
    825.00            +0.3%     827.33            +0.6%     830.30        slabinfo.kmalloc-1k.num_objs
    103.00            +0.2%     103.17            +0.3%     103.30        slabinfo.kmalloc-1k.num_slabs
      1593            +0.3%       1598            +0.5%       1602        slabinfo.kmalloc-256.active_objs
    102.33            +0.5%     102.83            +0.5%     102.80        slabinfo.kmalloc-256.active_slabs
      1649            +0.5%       1657            +0.2%       1653        slabinfo.kmalloc-256.num_objs
    102.33            +0.5%     102.83            +0.5%     102.80        slabinfo.kmalloc-256.num_slabs
    528.33            +0.6%     531.67            +0.9%     533.20        slabinfo.kmalloc-2k.active_objs
     65.17            +0.8%      65.67            +1.0%      65.80        slabinfo.kmalloc-2k.active_slabs
    528.33            +0.6%     531.67            +0.9%     533.20        slabinfo.kmalloc-2k.num_objs
     65.17            +0.8%      65.67            +1.0%      65.80        slabinfo.kmalloc-2k.num_slabs
     15023            +0.0%      15027            +0.2%      15050        slabinfo.kmalloc-32.active_objs
    118.17            +0.1%     118.33            +0.3%     118.50        slabinfo.kmalloc-32.active_slabs
     15197            -0.1%      15185            +0.3%      15247        slabinfo.kmalloc-32.num_objs
    118.17            +0.1%     118.33            +0.3%     118.50        slabinfo.kmalloc-32.num_slabs
    198.33            +0.3%     198.83            +0.3%     199.00        slabinfo.kmalloc-4k.active_objs
     24.00            +0.7%      24.17            +0.8%      24.20        slabinfo.kmalloc-4k.active_slabs
    199.00            +0.7%     200.33            +0.7%     200.40        slabinfo.kmalloc-4k.num_objs
     24.00            +0.7%      24.17            +0.8%      24.20        slabinfo.kmalloc-4k.num_slabs
    757.00 ±  3%      -1.2%     747.67            +1.2%     766.00 ±  3%  slabinfo.kmalloc-512.active_objs
    100.50 ±  4%      -0.8%      99.67 ±  3%      +2.6%     103.10 ±  4%  slabinfo.kmalloc-512.active_slabs
    808.33 ±  4%      -1.0%     800.33 ±  3%      +2.4%     828.10 ±  5%  slabinfo.kmalloc-512.num_objs
    100.50 ±  4%      -0.8%      99.67 ±  3%      +2.6%     103.10 ±  4%  slabinfo.kmalloc-512.num_slabs
     33761            +0.3%      33867            +0.1%      33810        slabinfo.kmalloc-64.active_objs
    528.17            +0.3%     530.00            +0.2%     529.00        slabinfo.kmalloc-64.active_slabs
     33829            +0.3%      33938            +0.2%      33882        slabinfo.kmalloc-64.num_objs
    528.17            +0.3%     530.00            +0.2%     529.00        slabinfo.kmalloc-64.num_slabs
      4064            +0.0%       4065            +0.0%       4066        slabinfo.kmalloc-8.active_objs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.kmalloc-8.active_slabs
      4096            +0.0%       4096            +0.0%       4096        slabinfo.kmalloc-8.num_objs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.kmalloc-8.num_slabs
     80.00            +0.0%      80.00            +0.0%      80.00        slabinfo.kmalloc-8k.active_objs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.kmalloc-8k.active_slabs
     80.00            +0.0%      80.00            +0.0%      80.00        slabinfo.kmalloc-8k.num_objs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.kmalloc-8k.num_slabs
    783.83 ±  2%      +0.1%     784.33 ±  2%      +2.8%     805.80 ±  4%  slabinfo.kmalloc-96.active_objs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.kmalloc-96.active_slabs
    878.83            -0.4%     875.00            +0.2%     881.00        slabinfo.kmalloc-96.num_objs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.kmalloc-96.num_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.kmalloc-cg-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-128.active_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.kmalloc-cg-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-128.num_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.kmalloc-cg-16.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-16.active_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.kmalloc-cg-16.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-16.num_slabs
     63.00            +0.0%      63.00            +0.0%      63.00        slabinfo.kmalloc-cg-192.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmalloc-cg-192.active_slabs
     63.00            +0.0%      63.00            +0.0%      63.00        slabinfo.kmalloc-cg-192.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmalloc-cg-192.num_slabs
    146.33            -2.1%     143.33            -0.8%     145.20 ±  3%  slabinfo.kmalloc-cg-1k.active_objs
     21.50 ±  5%      -7.0%      20.00 ±  2%      -6.0%      20.20 ±  6%  slabinfo.kmalloc-cg-1k.active_slabs
    172.00 ±  5%      -6.7%     160.50 ±  2%      -5.7%     162.20 ±  5%  slabinfo.kmalloc-cg-1k.num_objs
     21.50 ±  5%      -7.0%      20.00 ±  2%      -6.0%      20.20 ±  6%  slabinfo.kmalloc-cg-1k.num_slabs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.kmalloc-cg-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-256.active_slabs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.kmalloc-cg-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-256.num_slabs
     22.83            -2.9%      22.17 ±  4%      -1.0%      22.60 ±  2%  slabinfo.kmalloc-cg-2k.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.kmalloc-cg-2k.active_slabs
     22.83            -2.9%      22.17 ±  4%      -1.0%      22.60 ±  2%  slabinfo.kmalloc-cg-2k.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.kmalloc-cg-2k.num_slabs
    128.00            +0.0%     128.00            +0.0%     128.00        slabinfo.kmalloc-cg-32.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-32.active_slabs
    128.00            +0.0%     128.00            +0.0%     128.00        slabinfo.kmalloc-cg-32.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-32.num_slabs
     15.67 ±  3%      -1.1%      15.50 ±  3%      -0.4%      15.60 ±  3%  slabinfo.kmalloc-cg-4k.active_objs
      1.67 ± 28%     -10.0%       1.50 ± 33%      -4.0%       1.60 ± 30%  slabinfo.kmalloc-cg-4k.active_slabs
     15.67 ±  3%      -1.1%      15.50 ±  3%      -0.4%      15.60 ±  3%  slabinfo.kmalloc-cg-4k.num_objs
      1.67 ± 28%     -10.0%       1.50 ± 33%      -4.0%       1.60 ± 30%  slabinfo.kmalloc-cg-4k.num_slabs
     64.00            +0.0%      64.00            +0.0%      64.00        slabinfo.kmalloc-cg-512.active_objs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.kmalloc-cg-512.active_slabs
     64.00            +0.0%      64.00            +0.0%      64.00        slabinfo.kmalloc-cg-512.num_objs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.kmalloc-cg-512.num_slabs
     64.00            +0.0%      64.00            +0.0%      64.00        slabinfo.kmalloc-cg-64.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-64.active_slabs
     64.00            +0.0%      64.00            +0.0%      64.00        slabinfo.kmalloc-cg-64.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-64.num_slabs
      1024            +0.0%       1024            +0.0%       1024        slabinfo.kmalloc-cg-8.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.kmalloc-cg-8.active_slabs
      1024            +0.0%       1024            +0.0%       1024        slabinfo.kmalloc-cg-8.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.kmalloc-cg-8.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.kmalloc-cg-96.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-96.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.kmalloc-cg-96.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-cg-96.num_slabs
    112.00 ± 35%     +33.3%     149.33 ± 15%     +22.9%     137.60 ± 20%  slabinfo.kmalloc-rcl-128.active_objs
      3.50 ± 35%     +33.3%       4.67 ± 15%     +22.9%       4.30 ± 20%  slabinfo.kmalloc-rcl-128.active_slabs
    112.00 ± 35%     +33.3%     149.33 ± 15%     +22.9%     137.60 ± 20%  slabinfo.kmalloc-rcl-128.num_objs
      3.50 ± 35%     +33.3%       4.67 ± 15%     +22.9%       4.30 ± 20%  slabinfo.kmalloc-rcl-128.num_slabs
     21.00            +0.0%      21.00            +0.0%      21.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     21.00            +0.0%      21.00            +0.0%      21.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      3314            -0.2%       3307            -0.2%       3309        slabinfo.kmalloc-rcl-64.active_objs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.kmalloc-rcl-64.active_slabs
      3327            +0.0%       3327            +0.0%       3327        slabinfo.kmalloc-rcl-64.num_objs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.kmalloc-rcl-64.num_slabs
    390.67 ±  5%      +6.0%     414.17            +4.5%     408.40 ±  4%  slabinfo.kmalloc-rcl-96.active_objs
     10.00            +0.0%      10.00            +0.0%      10.00        slabinfo.kmalloc-rcl-96.active_slabs
    420.00            +0.0%     420.00            +0.0%     420.00        slabinfo.kmalloc-rcl-96.num_objs
     10.00            +0.0%      10.00            +0.0%      10.00        slabinfo.kmalloc-rcl-96.num_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmem_cache.active_objs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.kmem_cache.active_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmem_cache.num_objs
     12.00            +0.0%      12.00            +0.0%      12.00        slabinfo.kmem_cache.num_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmem_cache_node.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmem_cache_node.active_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmem_cache_node.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmem_cache_node.num_slabs
      1544 ±  3%      -0.2%       1541 ±  2%      +0.3%       1548        slabinfo.lsm_file_cache.active_objs
     10.33 ±  4%      +1.6%      10.50 ±  4%      +2.6%      10.60 ±  4%  slabinfo.lsm_file_cache.active_slabs
      1849 ±  2%      +1.9%       1884 ±  3%      +1.7%       1880 ±  3%  slabinfo.lsm_file_cache.num_objs
     10.33 ±  4%      +1.6%      10.50 ±  4%      +2.6%      10.60 ±  4%  slabinfo.lsm_file_cache.num_slabs
    117.17            +0.4%     117.67 ±  2%      +0.4%     117.60 ±  2%  slabinfo.mm_struct.active_objs
      9.67 ±  4%      -1.7%       9.50 ±  5%      -6.9%       9.00        slabinfo.mm_struct.active_slabs
    150.50 ±  4%      -1.9%     147.67 ±  2%      -5.4%     142.40        slabinfo.mm_struct.num_objs
      9.67 ±  4%      -1.7%       9.50 ±  5%      -6.9%       9.00        slabinfo.mm_struct.num_slabs
    263.50 ± 13%      +9.2%     287.83 ±  9%      +0.0%     263.50 ± 13%  slabinfo.mnt_cache.active_objs
     21.50 ± 16%     +10.9%      23.83 ± 10%      +0.0%      21.50 ± 16%  slabinfo.mnt_cache.active_slabs
    263.50 ± 13%      +9.2%     287.83 ±  9%      +0.0%     263.50 ± 13%  slabinfo.mnt_cache.num_objs
     21.50 ± 16%     +10.9%      23.83 ± 10%      +0.0%      21.50 ± 16%  slabinfo.mnt_cache.num_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
     30.17 ±  6%      +0.0%      30.17 ±  5%      -0.2%      30.10 ±  5%  slabinfo.names_cache.active_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.names_cache.active_slabs
     56.50            +0.6%      56.83            -0.2%      56.40        slabinfo.names_cache.num_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.names_cache.num_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.nfs_read_data.active_objs
      4.00            +0.0%       4.00            +0.0%       4.00        slabinfo.nfs_read_data.active_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.nfs_read_data.num_objs
      4.00            +0.0%       4.00            +0.0%       4.00        slabinfo.nfs_read_data.num_slabs
     56.00            +0.0%      56.00            +0.0%      56.00        slabinfo.nsproxy.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nsproxy.active_slabs
     56.00            +0.0%      56.00            +0.0%      56.00        slabinfo.nsproxy.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nsproxy.num_slabs
     17.50 ± 31%      +0.0%      17.50 ± 31%     -14.3%      15.00        slabinfo.numa_policy.active_objs
      1.17 ± 31%      +0.0%       1.17 ± 31%     -14.3%       1.00        slabinfo.numa_policy.active_slabs
     17.50 ± 31%      +0.0%      17.50 ± 31%     -14.3%      15.00        slabinfo.numa_policy.num_objs
      1.17 ± 31%      +0.0%       1.17 ± 31%     -14.3%       1.00        slabinfo.numa_policy.num_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.pde_opener.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.pde_opener.active_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.pde_opener.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.pde_opener.num_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.perf_event.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.perf_event.active_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.perf_event.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.perf_event.num_slabs
    353.33 ±  3%      -1.6%     347.67            -1.4%     348.40        slabinfo.pid.active_objs
     11.00            +0.0%      11.00            +0.0%      11.00        slabinfo.pid.active_slabs
    376.17            -2.6%     366.33 ±  2%      -3.4%     363.40        slabinfo.pid.num_objs
     11.00            +0.0%      11.00            +0.0%      11.00        slabinfo.pid.num_slabs
    107.83 ±  4%      +2.9%     111.00            +2.8%     110.90        slabinfo.pool_workqueue.active_objs
      6.00            +0.0%       6.00            +0.0%       6.00        slabinfo.pool_workqueue.active_slabs
    107.83 ±  4%      +2.9%     111.00            +2.8%     110.90        slabinfo.pool_workqueue.num_objs
      6.00            +0.0%       6.00            +0.0%       6.00        slabinfo.pool_workqueue.num_slabs
    588.00            +0.0%     588.00            +0.0%     588.00        slabinfo.proc_dir_entry.active_objs
     28.00            +0.0%      28.00            +0.0%      28.00        slabinfo.proc_dir_entry.active_slabs
    588.00            +0.0%     588.00            +0.0%     588.00        slabinfo.proc_dir_entry.num_objs
     28.00            +0.0%      28.00            +0.0%      28.00        slabinfo.proc_dir_entry.num_slabs
    240.67 ±  5%      +2.6%     246.83 ±  6%      +2.8%     247.30 ±  7%  slabinfo.proc_inode_cache.active_objs
     28.83 ±  5%      +5.8%      30.50 ±  4%      +3.7%      29.90 ±  6%  slabinfo.proc_inode_cache.active_slabs
    322.50 ±  5%      +5.5%     340.33 ±  4%      +3.4%     333.50 ±  6%  slabinfo.proc_inode_cache.num_objs
     28.83 ±  5%      +5.8%      30.50 ±  4%      +3.7%      29.90 ±  6%  slabinfo.proc_inode_cache.num_slabs
     24250            -1.3%      23944            -0.0%      24246        slabinfo.radix_tree_node.active_objs
      1769            -1.3%       1746            -0.0%       1769        slabinfo.radix_tree_node.active_slabs
     24783            -1.3%      24456            -0.0%      24776        slabinfo.radix_tree_node.num_objs
      1769            -1.3%       1746            -0.0%       1769        slabinfo.radix_tree_node.num_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.request_queue.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.request_queue.active_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.request_queue.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.request_queue.num_slabs
     22.00            +0.0%      22.00            +0.0%      22.00        slabinfo.rpc_inode_cache.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.rpc_inode_cache.active_slabs
     22.00            +0.0%      22.00            +0.0%      22.00        slabinfo.rpc_inode_cache.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.rpc_inode_cache.num_slabs
    896.00            +0.0%     896.00            +0.0%     896.00        slabinfo.scsi_sense_cache.active_objs
     28.00            +0.0%      28.00            +0.0%      28.00        slabinfo.scsi_sense_cache.active_slabs
    896.00            +0.0%     896.00            +0.0%     896.00        slabinfo.scsi_sense_cache.num_objs
     28.00            +0.0%      28.00            +0.0%      28.00        slabinfo.scsi_sense_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.seq_file.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.seq_file.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.seq_file.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.seq_file.num_slabs
    944.00            +0.0%     944.00            +0.0%     944.00        slabinfo.shmem_inode_cache.active_objs
     44.00            +0.0%      44.00            +0.0%      44.00        slabinfo.shmem_inode_cache.active_slabs
    944.00            +0.0%     944.00            +0.0%     944.00        slabinfo.shmem_inode_cache.num_objs
     44.00            +0.0%      44.00            +0.0%      44.00        slabinfo.shmem_inode_cache.num_slabs
    224.33            +0.1%     224.67            +0.2%     224.80        slabinfo.sighand_cache.active_objs
     16.50 ±  3%      +0.0%      16.50 ±  3%      -1.8%      16.20 ±  2%  slabinfo.sighand_cache.active_slabs
    251.83            +0.0%     251.83 ±  2%      -0.7%     250.00        slabinfo.sighand_cache.num_objs
     16.50 ±  3%      +0.0%      16.50 ±  3%      -1.8%      16.20 ±  2%  slabinfo.sighand_cache.num_slabs
    228.83            -0.4%     227.83            -0.4%     227.90        slabinfo.signal_cache.active_objs
     18.17 ±  4%      -2.8%      17.67 ±  2%      -2.6%      17.70 ±  2%  slabinfo.signal_cache.active_slabs
    260.50 ±  3%      -1.7%     256.00            -1.8%     255.70        slabinfo.signal_cache.num_objs
     18.17 ±  4%      -2.8%      17.67 ±  2%      -2.6%      17.70 ±  2%  slabinfo.signal_cache.num_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.sigqueue.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.sigqueue.active_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.sigqueue.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.sigqueue.num_slabs
     18.50 ± 18%     +13.5%      21.00 ±  4%      -5.4%      17.50 ± 17%  slabinfo.skbuff_fclone_cache.active_objs
      1.50 ± 33%     +33.3%       2.00            -6.7%       1.40 ± 34%  slabinfo.skbuff_fclone_cache.active_slabs
     18.50 ± 18%     +13.5%      21.00 ±  4%      -5.4%      17.50 ± 17%  slabinfo.skbuff_fclone_cache.num_objs
      1.50 ± 33%     +33.3%       2.00            -6.7%       1.40 ± 34%  slabinfo.skbuff_fclone_cache.num_slabs
    130.67 ± 11%      +7.7%     140.67 ±  9%      +0.0%     130.70 ±  8%  slabinfo.skbuff_head_cache.active_objs
     11.83 ± 16%      +9.9%      13.00 ±  8%      -7.9%      10.90 ± 18%  slabinfo.skbuff_head_cache.active_slabs
    191.67 ± 15%      +8.5%     208.00 ±  8%      -8.5%     175.40 ± 18%  slabinfo.skbuff_head_cache.num_objs
     11.83 ± 16%      +9.9%      13.00 ±  8%      -7.9%      10.90 ± 18%  slabinfo.skbuff_head_cache.num_slabs
    133.00            +0.0%     133.00            +0.0%     133.00        slabinfo.sock_inode_cache.active_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.sock_inode_cache.active_slabs
    133.00            +0.0%     133.00            +0.0%     133.00        slabinfo.sock_inode_cache.num_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.sock_inode_cache.num_slabs
     22.00            +0.0%      22.00            +0.0%      22.00        slabinfo.task_group.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.task_group.active_slabs
     22.00            +0.0%      22.00            +0.0%      22.00        slabinfo.task_group.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.task_group.num_slabs
    225.33            +0.1%     225.50            -0.3%     224.60        slabinfo.task_struct.active_objs
     79.17            -1.1%      78.33            -0.7%      78.60        slabinfo.task_struct.active_slabs
    238.67            -1.0%     236.17            -0.7%     237.10        slabinfo.task_struct.num_objs
     79.17            -1.1%      78.33            -0.7%      78.60        slabinfo.task_struct.num_slabs
     11.00            +0.0%      11.00            +0.0%      11.00        slabinfo.taskstats.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.taskstats.active_slabs
     11.00            +0.0%      11.00            +0.0%      11.00        slabinfo.taskstats.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.taskstats.num_slabs
      2568            +0.0%       2568            +0.0%       2568        slabinfo.trace_event_file.active_objs
     55.00            +0.0%      55.00            +0.0%      55.00        slabinfo.trace_event_file.active_slabs
      2568            +0.0%       2568            +0.0%       2568        slabinfo.trace_event_file.num_objs
     55.00            +0.0%      55.00            +0.0%      55.00        slabinfo.trace_event_file.num_slabs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
      4780            +0.0%       4781            -0.2%       4768        slabinfo.vm_area_struct.active_objs
    249.67            -0.4%     248.67            +0.5%     251.00        slabinfo.vm_area_struct.active_slabs
      5000            -0.2%       4989            +0.5%       5026        slabinfo.vm_area_struct.num_objs
    249.67            -0.4%     248.67            +0.5%     251.00        slabinfo.vm_area_struct.num_slabs
    877.33            +0.9%     885.50            +0.8%     884.70        slabinfo.vmap_area.active_objs
     17.17 ±  5%      -6.8%      16.00            -4.5%      16.40 ±  2%  slabinfo.vmap_area.active_slabs
      1113 ±  3%      -3.6%       1072            -3.3%       1076        slabinfo.vmap_area.num_objs
     17.17 ±  5%      -6.8%      16.00            -4.5%      16.40 ±  2%  slabinfo.vmap_area.num_slabs
     10.00            +0.0%      10.00            +0.0%      10.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     10.00            +0.0%      10.00            +0.0%      10.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     30.00            +5.6%      31.67 ± 11%      +0.0%      30.00        slabinfo.xfs_buf.active_objs
      3.00            +5.6%       3.17 ± 11%      +0.0%       3.00        slabinfo.xfs_buf.active_slabs
     30.00            +5.6%      31.67 ± 11%      +0.0%      30.00        slabinfo.xfs_buf.num_objs
      3.00            +5.6%       3.17 ± 11%      +0.0%       3.00        slabinfo.xfs_buf.num_slabs
     19.00            +0.0%      19.00            +0.0%      19.00        slabinfo.xfs_efi_item.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfs_efi_item.active_slabs
     19.00            +0.0%      19.00            +0.0%      19.00        slabinfo.xfs_efi_item.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfs_efi_item.num_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.xfs_inode.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfs_inode.active_slabs
      8.00            +0.0%       8.00            +0.0%       8.00        slabinfo.xfs_inode.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfs_inode.num_slabs
      5.24 ±  6%      -1.8        3.47 ± 17%      -0.1        5.10 ± 10%  perf-profile.calltrace.cycles-pp.ret_from_fork
      5.24 ±  6%      -1.8        3.47 ± 17%      -0.1        5.10 ± 10%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.01 ±  8%      -1.0        0.00            -0.1        0.89 ± 10%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      1.70 ± 15%      -1.0        0.72 ± 56%      -0.0        1.65 ± 18%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      5.32 ± 10%      -1.0        4.35 ± 27%      +0.1        5.43 ± 16%  perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      0.97 ± 16%      -1.0        0.00            -0.0        0.93 ± 26%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork
      0.94 ± 17%      -0.9        0.00            -0.0        0.92 ± 27%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      9.48 ±  9%      -0.9        8.62 ±  9%      -0.0        9.47 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.80 ± 12%      -0.7        4.15 ± 17%      -0.4        4.41 ±  9%  perf-profile.calltrace.cycles-pp.unlink
      3.35 ± 17%      -0.6        2.70 ± 11%      -0.4        2.94 ±  8%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.44 ± 15%      -0.6        5.80 ±  9%      -0.4        5.99 ±  6%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      4.73 ± 12%      -0.6        4.09 ± 18%      -0.4        4.31 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.74 ± 12%      -0.6        4.10 ± 17%      -0.4        4.32 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      0.63 ± 21%      -0.6        0.00            -0.5        0.12 ±200%  perf-profile.calltrace.cycles-pp.__submit_flush_wait.issue_flush_thread.kthread.ret_from_fork
      0.63 ± 21%      -0.6        0.00            -0.5        0.12 ±200%  perf-profile.calltrace.cycles-pp.blkdev_issue_flush.__submit_flush_wait.issue_flush_thread.kthread.ret_from_fork
      3.26 ± 17%      -0.6        2.64 ± 13%      -0.4        2.84 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_evict_inode.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.62 ± 20%      -0.6        0.00            -0.5        0.12 ±200%  perf-profile.calltrace.cycles-pp.submit_bio_wait.blkdev_issue_flush.__submit_flush_wait.issue_flush_thread.kthread
      4.68 ± 13%      -0.6        4.07 ± 18%      -0.4        4.27 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.61 ± 13%      -0.6        4.01 ± 18%      -0.4        4.22 ± 10%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.80 ± 58%      -0.6        0.20 ±223%      -0.1        0.74 ± 84%  perf-profile.calltrace.cycles-pp.__checkpoint_and_complete_reqs.issue_checkpoint_thread.kthread.ret_from_fork
      0.80 ± 58%      -0.6        0.20 ±223%      -0.1        0.74 ± 84%  perf-profile.calltrace.cycles-pp.__write_checkpoint_sync.__checkpoint_and_complete_reqs.issue_checkpoint_thread.kthread.ret_from_fork
      0.80 ± 58%      -0.6        0.20 ±223%      -0.1        0.74 ± 84%  perf-profile.calltrace.cycles-pp.issue_checkpoint_thread.kthread.ret_from_fork
      0.80 ± 58%      -0.6        0.20 ±223%      -0.1        0.74 ± 84%  perf-profile.calltrace.cycles-pp.f2fs_write_checkpoint.__write_checkpoint_sync.__checkpoint_and_complete_reqs.issue_checkpoint_thread.kthread
      0.67 ± 16%      -0.6        0.09 ±223%      -0.2        0.42 ± 86%  perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      0.77 ± 59%      -0.6        0.20 ±223%      -0.1        0.71 ± 84%  perf-profile.calltrace.cycles-pp.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync.__checkpoint_and_complete_reqs.issue_checkpoint_thread
      4.83 ± 20%      -0.6        4.27 ±  9%      -0.4        4.45 ±  8%  perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      5.72 ± 15%      -0.5        5.18 ± 10%      -0.3        5.40 ±  6%  perf-profile.calltrace.cycles-pp.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.29 ±  7%      -0.5        6.76 ±  9%      -0.3        7.04 ±  5%  perf-profile.calltrace.cycles-pp.__xstat64
      0.86 ± 33%      -0.5        0.33 ±146%      -0.1        0.75 ± 51%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.50 ±137%      -0.5        0.00            -0.3        0.17 ±152%  perf-profile.calltrace.cycles-pp.f2fs_find_in_inline_dir.__f2fs_find_entry.f2fs_lookup.__lookup_slow.walk_component
      0.81 ±117%      -0.5        0.31 ±223%      -0.5        0.33 ±135%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt
      0.81 ±117%      -0.5        0.31 ±223%      -0.5        0.33 ±135%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__softirqentry_text_start.irq_exit_rcu.common_interrupt
      0.81 ±117%      -0.5        0.31 ±223%      -0.5        0.33 ±135%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__softirqentry_text_start.irq_exit_rcu
      0.81 ±117%      -0.5        0.31 ±223%      -0.5        0.33 ±135%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__softirqentry_text_start
      4.67 ± 20%      -0.5        4.17 ±  9%      -0.4        4.32 ±  8%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx.__do_sys_newstat
      6.57 ±  8%      -0.5        6.08 ±  9%      -0.3        6.26 ±  5%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      6.76 ±  8%      -0.5        6.28 ±  9%      -0.3        6.47 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      6.82 ±  8%      -0.5        6.34 ±  9%      -0.3        6.55 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      0.61 ± 45%      -0.5        0.15 ±223%      +0.0        0.62 ± 36%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      5.82 ± 13%      -0.5        5.36 ±  7%      -0.6        5.20 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.96 ± 12%      -0.4        5.51 ±  7%      -0.6        5.32 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      6.45 ± 11%      -0.4        6.01 ±  6%      -0.7        5.78 ±  4%  perf-profile.calltrace.cycles-pp.__libc_pread
      5.76 ± 13%      -0.4        5.32 ±  7%      -0.6        5.15 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_file_read_iter.new_sync_read.vfs_read.ksys_pread64.do_syscall_64
      5.70 ± 13%      -0.4        5.26 ±  8%      -0.6        5.06 ±  4%  perf-profile.calltrace.cycles-pp.filemap_read.f2fs_file_read_iter.new_sync_read.vfs_read.ksys_pread64
      6.14 ± 11%      -0.4        5.71 ±  6%      -0.6        5.50 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      6.02 ± 12%      -0.4        5.60 ±  7%      -0.6        5.40 ±  4%  perf-profile.calltrace.cycles-pp.ksys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      0.51 ±137%      -0.4        0.08 ±223%      -0.2        0.28 ±100%  perf-profile.calltrace.cycles-pp.__f2fs_find_entry.f2fs_lookup.__lookup_slow.walk_component.path_lookupat
      6.19 ± 11%      -0.4        5.79 ±  6%      -0.7        5.54 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pread
      1.90 ± 31%      -0.4        1.52 ± 17%      -0.3        1.56 ± 10%  perf-profile.calltrace.cycles-pp.asm_common_interrupt
      1.60 ± 61%      -0.4        1.22 ± 10%      -0.3        1.28 ± 18%  perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      0.38 ± 70%      -0.4        0.00            -0.3        0.11 ±200%  perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync
      0.37 ± 70%      -0.4        0.00            -0.3        0.06 ±300%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.37 ± 70%      -0.4        0.00            -0.3        0.06 ±300%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.70 ± 11%      -0.3        0.36 ± 70%      -0.1        0.64 ± 14%  perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range
      0.70 ± 12%      -0.3        0.36 ± 70%      -0.1        0.64 ± 14%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit.folio_wait_writeback.__filemap_fdatawait_range
      0.86 ± 11%      -0.3        0.53 ± 71%      +0.0        0.90 ± 16%  perf-profile.calltrace.cycles-pp.f2fs_convert_inline_page.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write
      1.26 ± 48%      -0.3        0.93 ± 13%      -0.5        0.80 ± 10%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     10.43 ±  8%      -0.3       10.10 ± 11%      -0.3       10.08 ±  9%  perf-profile.calltrace.cycles-pp.fsync
     10.31 ±  8%      -0.3        9.98 ± 11%      -0.4        9.96 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
      0.91 ± 10%      -0.3        0.59 ± 45%      -0.2        0.70 ± 12%  perf-profile.calltrace.cycles-pp.issue_flush_thread.kthread.ret_from_fork
      1.78 ± 30%      -0.3        1.45 ± 18%      -0.3        1.44 ± 10%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt
      1.29 ± 46%      -0.3        0.97 ± 12%      -0.5        0.82 ± 10%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     10.32 ±  8%      -0.3        9.99 ± 11%      -0.4        9.96 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
      1.32 ± 46%      -0.3        1.00 ± 13%      -0.5        0.84 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.32 ± 45%      -0.3        1.01 ± 12%      -0.5        0.84 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     10.26 ±  9%      -0.3        9.95 ± 11%      -0.3        9.92 ±  9%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
      0.31 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.f2fs_find_target_dentry.f2fs_find_in_inline_dir.__f2fs_find_entry.f2fs_lookup.__lookup_slow
     10.27 ±  9%      -0.3        9.96 ± 11%      -0.3        9.93 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
      0.30 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.filemap_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      0.30 ±223%      -0.3        0.00            -0.0        0.26 ±228%  perf-profile.calltrace.cycles-pp.create_page_buffers.__block_write_begin_int.block_write_begin.generic_perform_write.__generic_file_write_iter
      0.30 ±223%      -0.3        0.00            -0.0        0.26 ±228%  perf-profile.calltrace.cycles-pp.create_empty_buffers.create_page_buffers.__block_write_begin_int.block_write_begin.generic_perform_write
      0.30 ±223%      -0.3        0.00            -0.0        0.26 ±228%  perf-profile.calltrace.cycles-pp.alloc_page_buffers.create_empty_buffers.create_page_buffers.__block_write_begin_int.block_write_begin
      0.30 ±223%      -0.3        0.00            -0.0        0.27 ±227%  perf-profile.calltrace.cycles-pp.__block_write_begin_int.block_write_begin.generic_perform_write.__generic_file_write_iter.blkdev_write_iter
      0.30 ±223%      -0.3        0.00            -0.1        0.20 ±299%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.create_page_buffers
      0.30 ±223%      -0.3        0.00            -0.0        0.26 ±229%  perf-profile.calltrace.cycles-pp.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.create_page_buffers.__block_write_begin_int
      0.83 ± 11%      -0.3        0.53 ± 44%      -0.1        0.77 ± 14%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.file_write_and_wait_range.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      0.29 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.new_sync_read.vfs_read.ksys_read
      0.83 ± 37%      -0.3        0.54 ± 83%      -0.2        0.64 ± 14%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.folio_wait_bit.folio_wait_writeback
      0.28 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.filemap_read.new_sync_read.vfs_read
      4.52 ± 14%      -0.3        4.24 ±  8%      -0.5        4.06 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.f2fs_file_read_iter.new_sync_read.vfs_read
      0.28 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.filemap_read.new_sync_read
      0.36 ± 70%      -0.3        0.09 ±223%      -0.3        0.05 ±300%  perf-profile.calltrace.cycles-pp.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      0.27 ±100%      -0.3        0.00            -0.2        0.06 ±299%  perf-profile.calltrace.cycles-pp.down_read.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync
      0.36 ± 70%      -0.3        0.09 ±223%      -0.0        0.35 ± 82%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.72 ± 10%      -0.3        0.45 ± 45%      -0.1        0.66 ± 13%  perf-profile.calltrace.cycles-pp.folio_wait_bit.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range.f2fs_do_sync_file
      0.27 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.filemap_read
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.copy_user_enhanced_fast_string.copyout.copy_page_to_iter
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.copy_user_enhanced_fast_string.copyout
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_common_interrupt.folio_mapping.__folio_start_writeback.__block_write_full_page.__writepage
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.folio_mapping.__folio_start_writeback.__block_write_full_page
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.f2fs_find_target_dentry.f2fs_find_in_inline_dir.__f2fs_find_entry.f2fs_lookup
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.f2fs_find_target_dentry.f2fs_find_in_inline_dir.__f2fs_find_entry
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.f2fs_find_target_dentry.f2fs_find_in_inline_dir
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.kmem_cache_alloc.alloc_buffer_head
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.f2fs_find_target_dentry
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.kmem_cache_alloc
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.folio_mapping.__folio_start_writeback.__block_write_full_page.__writepage.write_cache_pages
      1.02 ± 13%      -0.3        0.76 ± 46%      -0.0        1.01 ±  8%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.f2fs_evict_inode.evict.do_unlinkat.__x64_sys_unlink
      0.72 ± 10%      -0.3        0.46 ± 45%      -0.0        0.68 ± 12%  perf-profile.calltrace.cycles-pp.folio_wait_writeback.__filemap_fdatawait_range.file_write_and_wait_range.f2fs_do_sync_file.do_fsync
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.copy_user_enhanced_fast_string
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.do_user_addr_fault.exc_page_fault
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.do_user_addr_fault
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt.folio_mapping
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt
      0.26 ±223%      -0.3        0.00            -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.folio_mapping.__folio_start_writeback
      1.35 ± 43%      -0.3        1.09 ± 13%      -0.4        0.90 ± 10%  perf-profile.calltrace.cycles-pp.read
      4.18 ± 15%      -0.2        3.94 ±  8%      -0.5        3.72 ±  3%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.filemap_read.f2fs_file_read_iter.new_sync_read
      1.17 ±  8%      -0.2        0.94 ± 14%      +0.1        1.31 ± 17%  perf-profile.calltrace.cycles-pp.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write
      0.91 ± 42%      -0.2        0.68 ± 76%      -0.3        0.62 ± 35%  perf-profile.calltrace.cycles-pp.truncate_node.f2fs_remove_inode_page.f2fs_evict_inode.evict.do_unlinkat
      0.81 ± 20%      -0.2        0.57 ± 49%      -0.0        0.76 ±  7%  perf-profile.calltrace.cycles-pp.f2fs_issue_flush.f2fs_do_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      0.37 ±102%      -0.2        0.14 ±223%      +0.0        0.42 ±104%  perf-profile.calltrace.cycles-pp.rwsem_wake.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync.__checkpoint_and_complete_reqs
      1.19 ±  5%      -0.2        0.96 ±  9%      +0.0        1.21 ±  9%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      2.38 ±  8%      -0.2        2.16 ± 13%      -0.1        2.26 ± 12%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      4.34 ±  5%      -0.2        4.12 ± 11%      -0.2        4.10 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.96 ± 67%      -0.2        0.74 ± 16%      -0.4        0.61 ±  8%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.36 ±103%      -0.2        0.14 ±223%      +0.1        0.42 ±104%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.block_operations.f2fs_write_checkpoint.__write_checkpoint_sync
      4.63 ±  5%      -0.2        4.42 ± 11%      -0.2        4.43 ±  4%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.35 ±103%      -0.2        0.14 ±223%      +0.1        0.41 ±104%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.block_operations.f2fs_write_checkpoint
      1.79 ±  8%      -0.2        1.58 ±  8%      -0.1        1.70 ±  7%  perf-profile.calltrace.cycles-pp.__fxstat64
      0.62 ±  9%      -0.2        0.41 ± 71%      -0.1        0.56 ± 35%  perf-profile.calltrace.cycles-pp.security_task_kill.group_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill
      4.30 ±  4%      -0.2        4.10 ± 11%      -0.2        4.06 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.20 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.filemap_read
      0.20 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.copy_user_enhanced_fast_string.copyout.copy_page_to_iter
      0.20 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.copy_user_enhanced_fast_string.copyout
      1.42 ±  6%      -0.2        1.22 ± 10%      -0.1        1.31 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fxstat64
      5.16 ± 10%      -0.2        4.96 ±  8%      +0.1        5.27 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.20 ±143%      -0.2        0.00            -0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.cp_new_stat.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      4.05 ± 15%      -0.2        3.86 ±  8%      -0.4        3.66 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.filemap_read.f2fs_file_read_iter
      0.90 ± 31%      -0.2        0.70 ± 56%      -0.1        0.82 ± 33%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      5.08 ± 10%      -0.2        4.89 ±  8%      +0.1        5.21 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±223%      -0.2        0.08 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt
      0.18 ±141%      -0.2        0.00            +0.1        0.28 ±100%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_wait_on_page_writeback.f2fs_convert_inline_page.f2fs_convert_inline_inode.f2fs_preallocate_blocks
      0.70 ± 23%      -0.2        0.52 ± 44%      -0.1        0.58 ± 37%  perf-profile.calltrace.cycles-pp.f2fs_truncate.f2fs_evict_inode.evict.do_unlinkat.__x64_sys_unlink
      4.26 ±  6%      -0.2        4.08 ±  7%      +0.2        4.44 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ± 12%      -0.2        0.56 ± 48%      +0.0        0.75 ± 18%  perf-profile.calltrace.cycles-pp.f2fs_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.18 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.____machine__findnew_thread.machine__process_fork_event.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush
      0.18 ±223%      -0.2        0.00            -0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.machine__process_fork_event.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.18 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.radix_tree_delete_item.__remove_ino_entry.truncate_node.f2fs_remove_inode_page.f2fs_evict_inode
      0.18 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__remove_ino_entry.truncate_node.f2fs_remove_inode_page.f2fs_evict_inode.evict
      0.92 ± 77%      -0.2        0.74 ± 10%      -0.2        0.77 ± 34%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.18 ±141%      -0.2        0.00            -0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.group_send_sig_info.kill_pid_info
      4.12 ±  5%      -0.2        3.95 ± 12%      -0.2        3.97 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64.nsinfo__new.thread__new.____machine__findnew_thread
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64.nsinfo__new.thread__new
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__xstat64.nsinfo__new.thread__new.____machine__findnew_thread.machine__process_fork_event
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64.nsinfo__new
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.thread__new.____machine__findnew_thread.machine__process_fork_event.machines__deliver_event.perf_session__deliver_event
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.nsinfo__new.thread__new.____machine__findnew_thread.machine__process_fork_event.machines__deliver_event
      1.36 ±  7%      -0.2        1.19 ± 11%      -0.1        1.26 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__radix_tree_lookup.radix_tree_delete_item.__remove_ino_entry.truncate_node.f2fs_remove_inode_page
      2.04 ±  4%      -0.2        1.88 ± 22%      +0.2        2.20 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.step_into.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode_pseudo.__ns_get_path.ns_get_path_cb.ns_get_path
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.pick_link.step_into.walk_component.path_lookupat.filename_lookup
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.proc_ns_get_link.pick_link.step_into.walk_component.path_lookupat
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.ns_get_path.proc_ns_get_link.pick_link.step_into.walk_component
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.ns_get_path_cb.ns_get_path.proc_ns_get_link.pick_link.step_into
      0.17 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__ns_get_path.ns_get_path_cb.ns_get_path.proc_ns_get_link.pick_link
      0.68 ± 23%      -0.2        0.52 ± 44%      -0.1        0.56 ± 37%  perf-profile.calltrace.cycles-pp.f2fs_do_truncate_blocks.f2fs_truncate.f2fs_evict_inode.evict.do_unlinkat
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__radix_tree_lookup.radix_tree_delete_item.__remove_ino_entry.truncate_node
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__radix_tree_lookup.radix_tree_delete_item.__remove_ino_entry
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__radix_tree_lookup.radix_tree_delete_item
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__radix_tree_lookup
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdir
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.mkdir
      4.16 ±  5%      -0.2        3.99 ± 12%      -0.2        3.95 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.55 ± 82%      -0.2        0.39 ± 73%      -0.0        0.53 ±109%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.alloc_inode.new_inode_pseudo.__ns_get_path.ns_get_path_cb
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.alloc_inode.new_inode_pseudo.__ns_get_path
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.alloc_inode.new_inode_pseudo
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.alloc_inode
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.new_inode_pseudo.__ns_get_path.ns_get_path_cb.ns_get_path.proc_ns_get_link
      0.69 ± 15%      -0.2        0.53 ± 48%      -0.2        0.51 ± 51%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      0.92 ±  6%      -0.2        0.76 ± 11%      +0.0        0.95 ±  9%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.00 ± 36%      -0.2        0.84 ± 53%      -0.2        0.75 ± 13%  perf-profile.calltrace.cycles-pp.f2fs_remove_inode_page.f2fs_evict_inode.evict.do_unlinkat.__x64_sys_unlink
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±223%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.f2fs_mkdir.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      1.19 ± 10%      -0.2        1.04 ± 12%      -0.1        1.09 ±  9%  perf-profile.calltrace.cycles-pp.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      0.15 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.90 ±  6%      -0.1        0.76 ± 11%      +0.0        0.94 ±  8%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      3.33 ±  8%      -0.1        3.19 ±  7%      +0.0        3.37 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_read_inline_dir.f2fs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_do_add_link.f2fs_mkdir.vfs_mkdir.do_mkdirat.__x64_sys_mkdir
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_add_dentry.f2fs_do_add_link.f2fs_mkdir.vfs_mkdir.do_mkdirat
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_add_inline_entry.f2fs_add_dentry.f2fs_do_add_link.f2fs_mkdir.vfs_mkdir
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt.copy_user_enhanced_fast_string
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.copy_user_enhanced_fast_string.copyin
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_vma.do_anonymous_page.__handle_mm_fault
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__filemap_get_folio.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__filemap_get_folio.pagecache_get_page
      0.53 ± 47%      -0.1        0.39 ± 72%      -0.0        0.50 ± 72%  perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter
      0.90 ± 13%      -0.1        0.76 ± 11%      -0.1        0.82 ± 19%  perf-profile.calltrace.cycles-pp.xa_load.f2fs_ra_node_page.f2fs_fill_dentries.f2fs_read_inline_dir.f2fs_readdir
      0.71 ± 18%      -0.1        0.57 ± 47%      +0.0        0.76 ± 27%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_init_inode_metadata.f2fs_add_inline_entry.f2fs_add_dentry.f2fs_do_add_link.f2fs_mkdir
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_new_node_page.f2fs_new_inode_page
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_new_node_page
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.prep_new_page.get_page_from_freelist.__alloc_pages.alloc_pages_vma.do_anonymous_page
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.kernel_init_free_pages.prep_new_page.get_page_from_freelist.__alloc_pages.alloc_pages_vma
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.clear_page_erms.kernel_init_free_pages.prep_new_page.get_page_from_freelist.__alloc_pages
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.do_sys_openat2.do_sys_open.do_syscall_64
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.do_sys_openat2.do_sys_open
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.do_sys_openat2
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__filemap_get_folio
      0.98 ± 14%      -0.1        0.85 ± 11%      -0.0        0.95 ± 19%  perf-profile.calltrace.cycles-pp.f2fs_ra_node_page.f2fs_fill_dentries.f2fs_read_inline_dir.f2fs_readdir.iterate_dir
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.common_file_perm.security_file_permission.vfs_read.ksys_read
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.common_file_perm.security_file_permission.vfs_read
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.common_file_perm.security_file_permission
      0.14 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.common_file_perm
      0.28 ±141%      -0.1        0.14 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.28 ±141%      -0.1        0.14 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.cpuidle_enter_state.cpuidle_enter.do_idle
      0.28 ±141%      -0.1        0.14 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.cpuidle_enter_state.cpuidle_enter
      0.28 ±141%      -0.1        0.14 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.cpuidle_enter_state
      1.85 ±  6%      -0.1        1.72 ±  9%      +0.1        1.96 ± 20%  perf-profile.calltrace.cycles-pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      1.19 ± 17%      -0.1        1.06 ± 29%      +0.1        1.29 ± 43%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.clear_page_erms.kernel_init_free_pages.prep_new_page.get_page_from_freelist
      0.13 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.clear_page_erms.kernel_init_free_pages.prep_new_page
      0.13 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.clear_page_erms.kernel_init_free_pages
      0.13 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.clear_page_erms
      0.49 ± 45%      -0.1        0.36 ± 71%      -0.0        0.47 ± 51%  perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.group_send_sig_info.kill_pid_info.kill_something_info
      0.86 ± 11%      -0.1        0.74 ± 18%      -0.0        0.84 ± 18%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.18 ± 13%      -0.1        1.06 ± 20%      -0.1        1.07 ± 17%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt
      0.12 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_common_interrupt.finish_task_switch.__schedule.schedule.io_schedule
      0.12 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.finish_task_switch.__schedule.schedule
      0.12 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.io_schedule.folio_wait_bit
      0.12 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      3.43 ±  9%      -0.1        3.32 ±  8%      +0.1        3.51 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__schedule.preempt_schedule_common.__cond_resched.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.preempt_schedule_common.__cond_resched.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt.finish_task_switch
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.finish_task_switch.__schedule
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.preempt_schedule_common.__cond_resched.f2fs_fsync_node_pages
      3.10 ±  6%      -0.1        2.99 ±  8%      +0.2        3.32 ±  9%  perf-profile.calltrace.cycles-pp.kill
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.find_get_pages_range_tag.pagevec_lookup_range_tag
      0.11 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.find_get_pages_range_tag
      2.68 ±  7%      -0.1        2.57 ± 10%      +0.0        2.68 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_fill_dentries.f2fs_read_inline_dir.f2fs_readdir.iterate_dir.__x64_sys_getdents64
      0.19 ±141%      -0.1        0.09 ±223%      +0.1        0.28 ±134%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
      0.10 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.finish_task_switch.__schedule.preempt_schedule_common.__cond_resched
      0.10 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.finish_task_switch.__schedule.preempt_schedule_common
      0.10 ±223%      -0.1        0.00            +0.0        0.12 ±201%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.finish_task_switch.__schedule
      0.10 ±223%      -0.1        0.00            +0.0        0.12 ±201%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.finish_task_switch
      3.98 ±  8%      -0.1        3.87 ±  7%      +0.2        4.17 ±  9%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.mem_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      0.71 ± 11%      -0.1        0.62 ± 44%      +0.1        0.78 ±  9%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat.do_syscall_64
      0.18 ±223%      -0.1        0.09 ±223%      -0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.09 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.09 ±223%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
      0.09 ±223%      -0.1        0.00            -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.delay_halt_tpause.delay_halt.wait_for_xmitr.serial8250_console_putchar.uart_console_write
      0.09 ±223%      -0.1        0.00            -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.__cond_resched.down_read.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.09 ±223%      -0.1        0.00            -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.preempt_schedule_common.__cond_resched.down_read.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.09 ±223%      -0.1        0.00            -0.0        0.09 ±299%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.18 ±141%      -0.1        0.09 ±223%      -0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.vfs_statx.__do_sys_newstat
      0.09 ±223%      -0.1        0.00            -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.__schedule.preempt_schedule_common.__cond_resched.down_read.__submit_merged_write_cond
      0.09 ±223%      -0.1        0.00            +0.0        0.11 ±300%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.filemap_add_folio.__filemap_get_folio.pagecache_get_page
      1.38 ± 11%      -0.1        1.29 ± 12%      +0.1        1.43 ± 31%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.27 ±223%      -0.1        0.19 ±223%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__folio_start_writeback.__block_write_full_page.__writepage.write_cache_pages.generic_writepages
      0.22 ±146%      -0.1        0.14 ±223%      -0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page
      0.22 ±146%      -0.1        0.14 ±223%      -0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      0.22 ±146%      -0.1        0.14 ±223%      -0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__filemap_add_folio.filemap_add_folio
      0.22 ±145%      -0.1        0.14 ±223%      -0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__filemap_add_folio
      0.76 ±  6%      -0.1        0.69 ± 13%      +0.0        0.80 ± 10%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.30 ±155%      -0.1        0.22 ±143%      -0.0        0.28 ±137%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.18 ±223%      -0.1        0.11 ±223%      +0.0        0.21 ±167%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.70 ± 16%      -0.1        0.63 ±  9%      -0.0        0.70 ± 20%  perf-profile.calltrace.cycles-pp.xas_load.xa_load.f2fs_ra_node_page.f2fs_fill_dentries.f2fs_read_inline_dir
      1.53 ±  2%      -0.1        1.45 ± 20%      +0.0        1.57 ± 18%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.18 ±141%      -0.1        0.11 ±223%      +0.0        0.22 ±122%  perf-profile.calltrace.cycles-pp.__blk_mq_run_hw_queue.process_one_work.worker_thread.kthread.ret_from_fork
      0.34 ±223%      -0.1        0.27 ±150%      +0.2        0.54 ±138%  perf-profile.calltrace.cycles-pp.block_write_begin.generic_perform_write.__generic_file_write_iter.blkdev_write_iter.new_sync_write
      0.30 ±155%      -0.1        0.23 ±144%      +0.0        0.33 ±114%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.70 ±107%      -0.1        0.62 ±  8%      -0.1        0.57 ± 51%  perf-profile.calltrace.cycles-pp.f2fs_lookup.__lookup_slow.walk_component.path_lookupat.filename_lookup
      0.83 ± 11%      -0.1        0.77 ±  7%      +0.0        0.87 ±  9%  perf-profile.calltrace.cycles-pp.group_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64
      0.47 ±223%      -0.1        0.41 ±170%      -0.2        0.29 ±170%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.copy_user_enhanced_fast_string
      0.24 ±147%      -0.1        0.18 ±141%      -0.1        0.11 ±201%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write
      0.24 ±147%      -0.1        0.18 ±141%      -0.1        0.11 ±201%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic
      1.45 ±  9%      -0.1        1.40 ±  7%      -0.0        1.42 ±  4%  perf-profile.calltrace.cycles-pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      1.01 ± 11%      -0.1        0.96 ± 21%      -0.1        0.91 ± 21%  perf-profile.calltrace.cycles-pp.handle_level_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      0.78 ± 16%      -0.0        0.73 ± 18%      +0.1        0.83 ± 26%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.77 ± 12%      -0.0        0.72 ± 12%      -0.2        0.61 ± 34%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      8.85 ±  5%      -0.0        8.80 ±  7%      -0.1        8.75 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.61 ± 13%      -0.0        1.57 ± 23%      +0.1        1.71 ± 11%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      0.57 ± 47%      -0.0        0.53 ± 46%      -0.1        0.52 ± 54%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.93 ±  9%      -0.0        0.89 ±  5%      +0.0        0.96 ±  9%  perf-profile.calltrace.cycles-pp.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.61 ±  5%      -0.0        2.57 ±  9%      +0.0        2.66 ± 16%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.vfs_statx
      0.32 ±143%      -0.0        0.28 ±141%      +0.0        0.34 ±102%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      9.00 ±  5%      -0.0        8.96 ±  7%      -0.0        8.99 ±  5%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ± 11%      -0.0        0.74 ± 12%      -0.1        0.68 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      2.07 ±  6%      -0.0        2.04 ±  6%      +0.1        2.20 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      0.13 ±223%      -0.0        0.10 ±223%      -0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_new_inode.f2fs_create.path_openat.do_filp_open
      0.12 ±223%      -0.0        0.09 ±223%      -0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.__schedule.schedule.rwsem_down_read_slowpath.f2fs_new_inode.f2fs_create
      0.18 ±141%      -0.0        0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.unmask_irq.handle_level_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      0.17 ±141%      -0.0        0.15 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.unmask_8259A_irq.unmask_irq.handle_level_irq.__common_interrupt.common_interrupt
      0.12 ±223%      -0.0        0.10 ±223%      -0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.schedule.rwsem_down_read_slowpath.f2fs_new_inode.f2fs_create.path_openat
      1.25 ±  8%      -0.0        1.23 ± 15%      +0.0        1.30 ± 12%  perf-profile.calltrace.cycles-pp.filldir64.f2fs_fill_dentries.f2fs_read_inline_dir.f2fs_readdir.iterate_dir
      2.15 ±  7%      -0.0        2.13 ±  7%      +0.2        2.30 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
      0.52 ± 44%      -0.0        0.50 ± 45%      +0.2        0.68 ± 13%  perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork
      0.18 ±141%      -0.0        0.17 ±141%      +0.2        0.34 ±106%  perf-profile.calltrace.cycles-pp.__get_node_page.f2fs_read_inline_dir.f2fs_readdir.iterate_dir.__x64_sys_getdents64
      1.02 ±  8%      -0.0        1.01 ±  7%      -0.0        1.00 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      2.11 ± 20%      -0.0        2.10 ± 32%      +0.2        2.28 ± 21%  perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      0.82 ± 16%      -0.0        0.81 ± 20%      +0.2        1.02 ± 46%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      2.08 ± 19%      -0.0        2.07 ± 33%      +0.2        2.26 ± 21%  perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync
      0.56 ± 45%      -0.0        0.55 ± 50%      +0.3        0.82 ± 61%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.56 ± 44%      -0.0        0.55 ± 50%      +0.3        0.83 ± 60%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.09 ±223%      -0.0        0.09 ±223%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.delay_halt.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      0.98 ±  5%      -0.0        0.97 ±  8%      -0.0        0.96 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.09 ±223%      -0.0        0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__radix_tree_lookup.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      -0.0        0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.f2fs_file_read_iter.new_sync_read
      0.09 ±223%      -0.0        0.08 ±223%      +0.0        0.09 ±300%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      1.08 ±  9%      +0.0        1.08 ± 26%      -0.1        0.96 ± 20%  perf-profile.calltrace.cycles-pp.mask_and_ack_8259A.handle_level_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.__entry_text_start.kill
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.check_preempt_wakeup.check_preempt_curr
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.check_preempt_wakeup
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.rwsem_wake.block_operations
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__mark_inode_dirty.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__mark_inode_dirty.filemap_dirty_folio.__set_page_dirty_nobuffers
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__mark_inode_dirty.filemap_dirty_folio
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__mark_inode_dirty
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.update_curr.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.finish_task_switch.__schedule.schedule.exit_to_user_mode_prepare
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.memchr.verify_dirent_name.filldir64.f2fs_fill_dentries
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.memchr.verify_dirent_name.filldir64
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.memchr.verify_dirent_name
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.memchr
      0.00            +0.0        0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.utime
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.__might_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.__might_resched.unmap_page_range.unmap_vmas
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt.__might_resched
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.__might_resched.unmap_page_range
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__get_user_nocheck_1.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__get_user_nocheck_1.fault_in_readable.fault_in_iov_iter_readable
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__get_user_nocheck_1.fault_in_readable
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__get_user_nocheck_1
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__might_resched.unmap_page_range.unmap_vmas.exit_mmap.mmput
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.wake_up_q.rwsem_wake.block_operations
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.wake_up_q.rwsem_wake
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.wake_up_q
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.__wake_up_common_lock.pipe_write.new_sync_write
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.create_page_buffers
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.__wake_up_common_lock.pipe_write
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.alloc_buffer_head.alloc_page_buffers.create_empty_buffers
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.__wake_up_common_lock
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.alloc_buffer_head.alloc_page_buffers
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.alloc_buffer_head
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.__pagevec_lru_add.folio_add_lru.filemap_add_folio
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.__pagevec_lru_add.folio_add_lru
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.__pagevec_lru_add
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.pagevec_lru_move_fn.folio_mark_accessed.__filemap_get_folio
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.pagevec_lru_move_fn.folio_mark_accessed
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.pagevec_lru_move_fn
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.pagevec_lru_move_fn.folio_mark_accessed.__filemap_get_folio.pagecache_get_page
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.__pagevec_lru_add.folio_add_lru.filemap_add_folio.__filemap_get_folio
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.__filemap_get_folio.pagecache_get_page.__get_node_page.f2fs_read_inline_dir
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.folio_mark_accessed.__filemap_get_folio.pagecache_get_page.__get_node_page
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt._raw_spin_unlock_irqrestore
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt._raw_spin_unlock_irqrestore.filemap_dirty_folio
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty.folio_mark_dirty
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.wake_up_new_task.kernel_clone.__do_sys_clone
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.wake_up_new_task.kernel_clone
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.wake_up_new_task
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__handle_mm_fault.handle_mm_fault
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__handle_mm_fault
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.restore_nameidata.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.restore_nameidata.do_filp_open.do_sys_openat2
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.restore_nameidata.do_filp_open
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.restore_nameidata
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.begin_new_exec.load_elf_binary
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.begin_new_exec
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.restore_nameidata.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.mod_delayed_work_on.blk_mq_dispatch_rq_list.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.mod_delayed_work_on.blk_mq_dispatch_rq_list.__blk_mq_sched_dispatch_requests
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.mod_delayed_work_on.blk_mq_dispatch_rq_list
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.mod_delayed_work_on
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.finish_task_switch.__schedule.schedule.worker_thread
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.blkdev_write_iter.new_sync_write
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.blkdev_write_iter
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.asm_common_interrupt._raw_spin_unlock_irqrestore.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt._raw_spin_unlock_irqrestore.filemap_dirty_folio.__set_page_dirty_nobuffers
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.mod_delayed_work_on.blk_mq_dispatch_rq_list.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.setlocale
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.memchr.verify_dirent_name.filldir64.f2fs_fill_dentries.f2fs_read_inline_dir
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.verify_dirent_name.filldir64.f2fs_fill_dentries.f2fs_read_inline_dir.f2fs_readdir
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.should_fail_alloc_page.__alloc_pages.folio_alloc.__filemap_get_folio
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.should_fail_alloc_page.__alloc_pages.folio_alloc
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.should_fail_alloc_page.__alloc_pages
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.should_fail_alloc_page
      0.00            +0.0        0.00            +0.1        0.08 ±299%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.__get_node_page.f2fs_read_inline_dir.f2fs_readdir
      0.00            +0.0        0.00            +0.1        0.08 ±299%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.worker_thread.kthread
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.pagecache_get_page.__get_node_page.f2fs_read_inline_dir.f2fs_readdir.iterate_dir
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.should_fail_alloc_page.__alloc_pages.folio_alloc.__filemap_get_folio.pagecache_get_page
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.__pagevec_release.f2fs_fsync_node_pages.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      0.00            +0.0        0.00            +0.1        0.09 ±300%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.1        0.09 ±300%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00            +0.1        0.09 ±300%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00            +0.1        0.09 ±300%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00            +0.1        0.09 ±300%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00            +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk
      0.00            +0.0        0.00            +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__d_lookup_rcu.lookup_fast.walk_component
      0.00            +0.0        0.00            +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__d_lookup_rcu.lookup_fast
      0.00            +0.0        0.00            +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__d_lookup_rcu
      0.00            +0.0        0.00            +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.00            +0.0        0.00            +0.1        0.11 ±200%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty
      0.00            +0.0        0.00            +0.1        0.11 ±200%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.filemap_dirty_folio.__set_page_dirty_nobuffers
      0.00            +0.0        0.00            +0.1        0.11 ±200%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.filemap_dirty_folio
      0.00            +0.0        0.00            +0.1        0.12 ±201%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.finish_task_switch.__schedule.schedule
      0.00            +0.0        0.00            +0.1        0.12 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.pagecache_get_page.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00            +0.1        0.12 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.00            +0.0        0.00            +0.1        0.12 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.pagecache_get_page.f2fs_write_begin
      0.00            +0.0        0.00            +0.1        0.12 ±299%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.pagecache_get_page
      0.00            +0.0        0.00            +0.1        0.12 ±202%  perf-profile.calltrace.cycles-pp.__schedule.schedule.rwsem_down_read_slowpath.f2fs_convert_inline_inode.f2fs_preallocate_blocks
      0.00            +0.0        0.00            +0.1        0.13 ±203%  perf-profile.calltrace.cycles-pp.schedule.rwsem_down_read_slowpath.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter
      0.00            +0.0        0.00            +0.1        0.13 ±203%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write
      0.00            +0.0        0.00            +0.1        0.13 ±299%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt.__task_pid_nr_ns
      0.00            +0.0        0.00            +0.1        0.13 ±299%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.__task_pid_nr_ns.__x64_sys_kill
      0.00            +0.0        0.00            +0.1        0.13 ±300%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.__task_pid_nr_ns.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.1        0.13 ±300%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.__task_pid_nr_ns.__x64_sys_kill.do_syscall_64
      0.00            +0.0        0.00            +0.2        0.15 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.free_unref_page_list.release_pages.__pagevec_release.truncate_inode_pages_range
      0.00            +0.0        0.00            +0.2        0.15 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.free_unref_page_list.release_pages.__pagevec_release
      0.00            +0.0        0.00            +0.2        0.15 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.free_unref_page_list.release_pages
      0.00            +0.0        0.00            +0.2        0.15 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.free_unref_page_list
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.balance_dirty_pages_ratelimited.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.balance_dirty_pages_ratelimited.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.balance_dirty_pages_ratelimited.generic_perform_write
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.balance_dirty_pages_ratelimited
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.blkdev_flush_mapping.blkdev_put.blkdev_close
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.blkdev_flush_mapping.blkdev_put
      0.00            +0.0        0.00            +0.2        0.16 ±300%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.__pagevec_release.truncate_inode_pages_range.blkdev_flush_mapping
      0.00            +0.0        0.00            +0.2        0.17 ±300%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.blkdev_flush_mapping.blkdev_put.blkdev_close.__fput
      0.00            +0.0        0.00            +0.2        0.17 ±300%  perf-profile.calltrace.cycles-pp.blkdev_close.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +0.2        0.17 ±300%  perf-profile.calltrace.cycles-pp.blkdev_put.blkdev_close.__fput.task_work_run.exit_to_user_mode_prepare
      0.00            +0.0        0.00            +0.2        0.17 ±300%  perf-profile.calltrace.cycles-pp.blkdev_flush_mapping.blkdev_put.blkdev_close.__fput.task_work_run
      0.00            +0.0        0.00            +0.2        0.17 ±300%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.blkdev_write_iter
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.get_obj_cgroup_from_current.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.get_obj_cgroup_from_current.kmem_cache_alloc.alloc_buffer_head
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.copy_page_from_iter_atomic.generic_perform_write
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_obj_cgroup_from_current.kmem_cache_alloc
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.copy_page_from_iter_atomic
      0.00            +0.0        0.00            +0.2        0.18 ±299%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_obj_cgroup_from_current
      0.00            +0.0        0.00            +0.2        0.18 ±300%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers
      0.00            +0.0        0.00            +0.2        0.19 ±152%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty.folio_mark_dirty
      0.18 ±141%      +0.0        0.19 ±141%      -0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.f2fs_file_read_iter.new_sync_read.vfs_read
      1.16 ± 19%      +0.0        1.16 ± 22%      +0.0        1.20 ± 16%  perf-profile.calltrace.cycles-pp.xas_find_marked.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.28 ±100%      +0.0        0.29 ±100%      -0.2        0.05 ±300%  perf-profile.calltrace.cycles-pp.find_lock_entries.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers.drop_caches_sysctl_handler
      0.40 ±117%      +0.0        0.40 ± 74%      +0.1        0.45 ± 78%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.78 ± 15%      +0.0        0.80 ± 22%      +0.2        1.01 ± 46%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.09 ±223%      +0.0        0.11 ±223%      +0.1        0.16 ±152%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.process_one_work.worker_thread.kthread
      0.09 ±223%      +0.0        0.11 ±223%      +0.1        0.16 ±152%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.process_one_work.worker_thread
      0.93 ± 16%      +0.0        0.94 ± 15%      +0.2        1.17 ± 40%  perf-profile.calltrace.cycles-pp.__close
      0.84 ±  6%      +0.0        0.86 ± 11%      +0.1        0.94 ± 40%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.50 ±149%      +0.0        0.52 ±162%      -0.3        0.19 ±202%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.blkdev_write_iter
      0.64 ±  9%      +0.0        0.67 ± 14%      +0.1        0.73 ± 56%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_lookupat
      0.81 ± 12%      +0.0        0.85 ±  9%      -0.1        0.74 ±  9%  perf-profile.calltrace.cycles-pp.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers.drop_caches_sysctl_handler.proc_sys_call_handler
      0.32 ±101%      +0.0        0.36 ± 70%      -0.1        0.24 ±123%  perf-profile.calltrace.cycles-pp.f2fs_truncate_data_blocks_range.f2fs_do_truncate_blocks.f2fs_truncate.f2fs_evict_inode.evict
      0.36 ± 70%      +0.0        0.40 ± 73%      +0.2        0.52 ± 58%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      1.07 ± 20%      +0.0        1.12 ± 32%      +0.1        1.13 ± 11%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      2.80 ±  8%      +0.0        2.84 ± 20%      +0.1        2.90 ±  9%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      0.50 ±150%      +0.0        0.55 ±161%      -0.1        0.41 ±170%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.blkdev_write_iter.new_sync_write
      0.98 ± 10%      +0.0        1.03 ±  9%      -0.0        0.94 ±  3%  perf-profile.calltrace.cycles-pp.drop_pagecache_sb.iterate_supers.drop_caches_sysctl_handler.proc_sys_call_handler.new_sync_write
      0.98 ± 10%      +0.0        1.03 ±  9%      -0.0        0.94 ±  4%  perf-profile.calltrace.cycles-pp.iterate_supers.drop_caches_sysctl_handler.proc_sys_call_handler.new_sync_write.vfs_write
      0.83 ±  9%      +0.0        0.88 ± 37%      -0.0        0.80 ± 15%  perf-profile.calltrace.cycles-pp.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write
      1.60 ± 45%      +0.0        1.64 ± 35%      +0.2        1.78 ± 53%  perf-profile.calltrace.cycles-pp.blkdev_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.99 ±  9%      +0.0        1.04 ±  8%      -0.0        0.94 ±  4%  perf-profile.calltrace.cycles-pp.drop_caches_sysctl_handler.proc_sys_call_handler.new_sync_write.vfs_write.ksys_write
      0.99 ± 20%      +0.0        1.04 ± 34%      +0.0        1.02 ± 11%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      1.60 ± 45%      +0.0        1.64 ± 35%      +0.2        1.78 ± 53%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.blkdev_write_iter.new_sync_write.vfs_write
      1.60 ± 45%      +0.0        1.64 ± 35%      +0.2        1.78 ± 53%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.blkdev_write_iter.new_sync_write.vfs_write.ksys_write
      1.25 ±  6%      +0.1        1.32 ±  7%      -0.0        1.23 ± 10%  perf-profile.calltrace.cycles-pp.__close_nocancel
      6.60 ±  9%      +0.1        6.66 ±  8%      +0.2        6.81 ±  5%  perf-profile.calltrace.cycles-pp.open64
      0.92 ± 36%      +0.1        0.99 ± 35%      -0.1        0.80 ± 15%  perf-profile.calltrace.cycles-pp.f2fs_new_node_page.f2fs_new_inode_page.f2fs_init_inode_metadata.f2fs_add_inline_entry.f2fs_add_dentry
      0.93 ± 35%      +0.1        1.00 ± 35%      -0.1        0.82 ± 14%  perf-profile.calltrace.cycles-pp.f2fs_new_inode_page.f2fs_init_inode_metadata.f2fs_add_inline_entry.f2fs_add_dentry.f2fs_do_add_link
      0.09 ±223%      +0.1        0.16 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_get_dnode_of_data.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write
      0.24 ±142%      +0.1        0.31 ±156%      +0.1        0.29 ±100%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +0.1        0.08 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.00            +0.1        0.09 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vt_console_print.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
      0.00            +0.1        0.09 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_unlock.vprintk_emit.devkmsg_emit
      0.00            +0.1        0.09 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64
      0.00            +0.1        0.09 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__vma_rb_erase
      1.12 ±142%      +0.1        1.21 ±142%      -0.4        0.67 ±202%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit._printk.irq_work_single
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.rb_erase.elv_rb_del.deadline_remove_request.__dd_dispatch_request
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__vma_rb_erase.__do_munmap.mmap_region.do_mmap
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.rb_erase.elv_rb_del.deadline_remove_request
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__vma_rb_erase.__do_munmap.mmap_region
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.rb_erase.elv_rb_del
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__vma_rb_erase.__do_munmap
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.rb_erase
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.rb_erase.elv_rb_del.deadline_remove_request.__dd_dispatch_request.dd_dispatch_request
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__vma_rb_erase.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.deadline_remove_request.__dd_dispatch_request.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.elv_rb_del.deadline_remove_request.__dd_dispatch_request.dd_dispatch_request.__blk_mq_do_dispatch_sched
      1.34 ± 12%      +0.1        1.44 ± 28%      -0.1        1.27 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_add_inline_entry.f2fs_add_dentry.f2fs_do_add_link.f2fs_create.path_openat
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__dd_dispatch_request.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.00            +0.1        0.10 ±223%      +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.generic_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      0.18 ±141%      +0.1        0.28 ±100%      +0.2        0.35 ± 82%  perf-profile.calltrace.cycles-pp.f2fs_wait_on_page_writeback.f2fs_convert_inline_page.f2fs_convert_inline_inode.f2fs_preallocate_blocks.f2fs_file_write_iter
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.f2fs_enable_inode_chksum.f2fs_inode_chksum_verify.read_node_page.__get_node_page
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.f2fs_enable_inode_chksum.f2fs_inode_chksum_verify.read_node_page
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.f2fs_enable_inode_chksum.f2fs_inode_chksum_verify
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.f2fs_enable_inode_chksum
      0.00            +0.1        0.10 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.get_mem_cgroup_from_mm.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio
      0.00            +0.1        0.10 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.get_mem_cgroup_from_mm.__mem_cgroup_charge.__filemap_add_folio
      0.00            +0.1        0.10 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_mem_cgroup_from_mm.__mem_cgroup_charge
      0.00            +0.1        0.10 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_mem_cgroup_from_mm
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__dentry_kill.dput.step_into.path_openat
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__dentry_kill.dput.step_into
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__dentry_kill.dput
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__dentry_kill
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_openat.do_filp_open
      1.03 ±  6%      +0.1        1.13 ±  6%      +0.1        1.12 ± 15%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.process_one_work
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.f2fs_inode_chksum_verify.read_node_page.__get_node_page.f2fs_get_dnode_of_data.f2fs_map_blocks
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.f2fs_enable_inode_chksum.f2fs_inode_chksum_verify.read_node_page.__get_node_page.f2fs_get_dnode_of_data
      0.00            +0.1        0.11 ±223%      +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      1.35 ± 12%      +0.1        1.46 ± 27%      -0.1        1.29 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_add_dentry.f2fs_do_add_link.f2fs_create.path_openat.do_filp_open
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.09 ±223%      +0.1        0.20 ±223%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.kallsyms__parse.__dso__load_kallsyms.dso__load.map__load.thread__find_map
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__dso__load_kallsyms.dso__load.map__load.thread__find_map.build_id__mark_dso_hit
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.rmqueue.get_page_from_freelist.__alloc_pages.folio_alloc
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.rmqueue.get_page_from_freelist.__alloc_pages
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.rmqueue.get_page_from_freelist
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.rmqueue
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.build_id__mark_dso_hit.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.thread__find_map.build_id__mark_dso_hit.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.map__load.thread__find_map.build_id__mark_dso_hit.machines__deliver_event.perf_session__deliver_event
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.dso__load.map__load.thread__find_map.build_id__mark_dso_hit.machines__deliver_event
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vsnprintf.seq_vprintf.seq_printf.s_show.seq_read_iter
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.seq_vprintf.seq_printf.s_show.seq_read_iter.seq_read
      0.26 ±100%      +0.1        0.38 ± 71%      -0.3        0.00        perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      0.94 ± 12%      +0.1        1.06 ± 24%      +0.3        1.21 ± 24%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty.folio_mark_dirty.f2fs_write_end.generic_perform_write
      6.10 ±  9%      +0.1        6.22 ±  8%      +0.2        6.33 ±  5%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.42 ± 11%      +0.1        1.55 ± 27%      -0.0        1.38 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_do_add_link.f2fs_create.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.seq_printf.s_show.seq_read_iter.seq_read.proc_reg_read
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.s_show.seq_read_iter.seq_read.proc_reg_read.vfs_read
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.read_node_page.__get_node_page.f2fs_get_dnode_of_data.f2fs_map_blocks.f2fs_preallocate_blocks
      1.19 ±  4%      +0.1        1.32 ±  9%      +0.1        1.28 ± 15%  perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.pagecache_get_page.f2fs_new_node_page
      0.00            +0.1        0.12 ±223%      +0.1        0.14 ±200%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page.block_write_begin
      6.08 ±  9%      +0.1        6.20 ±  8%      +0.2        6.29 ±  5%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.14 ±223%      +0.1        0.26 ±152%      -0.1        0.00        perf-profile.calltrace.cycles-pp.pagecache_get_page.f2fs_new_node_page.f2fs_new_inode_page.f2fs_init_inode_metadata.f2fs_add_inline_entry
      0.14 ±223%      +0.1        0.26 ±152%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.f2fs_new_node_page.f2fs_new_inode_page.f2fs_init_inode_metadata
      6.27 ±  9%      +0.1        6.40 ±  8%      +0.3        6.52 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.1        0.13 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.pagecache_get_page.f2fs_new_node_page.f2fs_new_inode_page
      0.14 ±223%      +0.1        0.27 ±100%      -0.1        0.00        perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit.folio_wait_writeback.f2fs_wait_on_page_writeback
      0.14 ±223%      +0.1        0.27 ±100%      -0.1        0.00        perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit.folio_wait_writeback.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback
      0.00            +0.1        0.14 ±223%      +0.2        0.15 ±200%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.pagecache_get_page.block_write_begin.generic_perform_write
      6.23 ±  9%      +0.1        6.37 ±  8%      +0.2        6.48 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.1        0.14 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.update_segment_mtime.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00            +0.1        0.14 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.update_segment_mtime.f2fs_allocate_data_block.do_write_page
      0.00            +0.1        0.14 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.update_segment_mtime.f2fs_allocate_data_block
      0.00            +0.1        0.14 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.update_segment_mtime
      0.88 ± 12%      +0.1        1.02 ± 23%      +0.3        1.17 ± 25%  perf-profile.calltrace.cycles-pp.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty.folio_mark_dirty.f2fs_write_end
      0.00            +0.1        0.14 ±223%      +0.5        0.46 ± 93%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore
      0.00            +0.1        0.14 ±223%      +0.1        0.12 ±200%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write.block_write_end
      0.00            +0.1        0.14 ±223%      +0.1        0.12 ±200%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
      0.00            +0.1        0.14 ±223%      +0.1        0.12 ±200%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work._raw_spin_unlock_irqrestore.mark_buffer_dirty
      0.00            +0.1        0.14 ±223%      +0.1        0.12 ±200%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write.block_write_end.blkdev_write_end
      0.27 ±223%      +0.1        0.42 ±169%      +0.0        0.29 ±171%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write
      0.27 ±223%      +0.1        0.42 ±169%      +0.0        0.29 ±171%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic
      0.27 ±223%      +0.1        0.42 ±169%      +0.0        0.29 ±171%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.copy_user_enhanced_fast_string.copyin
      0.09 ±223%      +0.1        0.24 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__invalidate_mapping_pages.truncate_node.f2fs_remove_inode_page.f2fs_evict_inode.evict
      0.00            +0.1        0.15 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.update_segment_mtime.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.00            +0.2        0.15 ±223%      +0.2        0.18 ±200%  perf-profile.calltrace.cycles-pp.pagecache_get_page.block_write_begin.generic_perform_write.__generic_file_write_iter.blkdev_write_iter
      0.00            +0.2        0.15 ±223%      +0.2        0.18 ±200%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.block_write_begin.generic_perform_write.__generic_file_write_iter
      0.14 ±223%      +0.2        0.29 ±100%      -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      0.14 ±223%      +0.2        0.29 ±100%      -0.1        0.00        perf-profile.calltrace.cycles-pp.folio_wait_writeback.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file.do_fsync
      0.14 ±223%      +0.2        0.29 ±100%      -0.1        0.00        perf-profile.calltrace.cycles-pp.folio_wait_bit.folio_wait_writeback.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file
      0.00            +0.2        0.15 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__get_node_page.f2fs_get_dnode_of_data.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter
      0.00            +0.2        0.15 ±223%      +0.1        0.14 ±200%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.blkdev_write_end.generic_perform_write
      0.00            +0.2        0.15 ±223%      +0.1        0.14 ±200%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.blkdev_write_end.generic_perform_write.__generic_file_write_iter
      0.14 ±223%      +0.2        0.30 ±100%      -0.1        0.00        perf-profile.calltrace.cycles-pp.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      0.00            +0.2        0.16 ±223%      +0.1        0.14 ±200%  perf-profile.calltrace.cycles-pp.block_write_end.blkdev_write_end.generic_perform_write.__generic_file_write_iter.blkdev_write_iter
      0.00            +0.2        0.16 ±223%      +0.1        0.15 ±200%  perf-profile.calltrace.cycles-pp.blkdev_write_end.generic_perform_write.__generic_file_write_iter.blkdev_write_iter.new_sync_write
      1.17 ± 22%      +0.2        1.33 ± 22%      +0.2        1.40 ± 20%  perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__folio_start_writeback
      0.00            +0.2        0.17 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.charge_memcg
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__folio_start_writeback.__block_write_full_page.__writepage.write_cache_pages
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__folio_start_writeback.__block_write_full_page.__writepage
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__folio_start_writeback.__block_write_full_page
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.proc_reg_read.vfs_read.ksys_read
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.2        0.17 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.17 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio
      0.00            +0.2        0.17 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.charge_memcg.__mem_cgroup_charge.__filemap_add_folio
      0.00            +0.2        0.17 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.charge_memcg.__mem_cgroup_charge
      0.00            +0.2        0.18 ±141%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.new_sync_read.vfs_read
      0.00            +0.2        0.18 ±141%      +0.0        0.00        perf-profile.calltrace.cycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__libc_read
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.f2fs_release_page.invalidate_inode_page.__invalidate_mapping_pages.truncate_node
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.f2fs_release_page.invalidate_inode_page.__invalidate_mapping_pages
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.f2fs_release_page.invalidate_inode_page
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.f2fs_release_page
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.invalidate_inode_page.__invalidate_mapping_pages.truncate_node.f2fs_remove_inode_page.f2fs_evict_inode
      0.00            +0.2        0.18 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.f2fs_release_page.invalidate_inode_page.__invalidate_mapping_pages.truncate_node.f2fs_remove_inode_page
      0.00            +0.2        0.19 ±141%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vt_console_print.console_unlock.vprintk_emit._printk.drop_caches_sysctl_handler.cold
      0.00            +0.2        0.19 ±141%      +0.0        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit._printk.f2fs_printk
      0.18 ±223%      +0.2        0.40 ±103%      -0.1        0.13 ±203%  perf-profile.calltrace.cycles-pp.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.process_simple
      0.09 ±223%      +0.2        0.30 ±102%      +0.1        0.19 ±156%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
      0.09 ±223%      +0.2        0.30 ±102%      +0.1        0.19 ±156%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
      0.09 ±223%      +0.2        0.30 ±102%      +0.1        0.19 ±156%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.09 ±223%      +0.2        0.30 ±102%      +0.1        0.19 ±156%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
      0.00            +0.2        0.22 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      0.00            +0.2        0.22 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.step_into.walk_component.link_path_walk.path_parentat
      0.00            +0.2        0.22 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.step_into.walk_component.link_path_walk
      0.00            +0.2        0.22 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.step_into.walk_component
      0.00            +0.2        0.22 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.step_into
      0.98 ± 14%      +0.2        1.20 ± 31%      +0.0        0.98 ± 16%  perf-profile.calltrace.cycles-pp.f2fs_init_inode_metadata.f2fs_add_inline_entry.f2fs_add_dentry.f2fs_do_add_link.f2fs_create
      0.00            +0.2        0.22 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_parentat.filename_parentat.do_unlinkat
      0.00            +0.2        0.22 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_parentat.filename_parentat
      0.18 ±223%      +0.2        0.41 ±103%      -0.1        0.13 ±203%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.process_simple.perf_session__process_events
      0.18 ±223%      +0.2        0.41 ±103%      -0.1        0.13 ±203%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.process_simple.perf_session__process_events.record__finish_output.cmd_record
      0.18 ±223%      +0.2        0.41 ±103%      -0.1        0.13 ±203%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.process_simple.perf_session__process_events.record__finish_output
      0.10 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_mq_submit_bio
      0.10 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.blk_mq_submit_bio.submit_bio_noacct.submit_bh_wbc.__block_write_full_page
      0.10 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_mq_submit_bio.submit_bio_noacct.submit_bh_wbc
      0.10 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_mq_submit_bio.submit_bio_noacct
      0.00            +0.2        0.23 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      0.00            +0.2        0.23 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched
      0.00            +0.2        0.23 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.scsi_queue_rq.blk_mq_dispatch_rq_list
      0.00            +0.2        0.23 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.scsi_queue_rq
      0.00            +0.2        0.23 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.link_path_walk.path_parentat.filename_parentat.do_unlinkat.__x64_sys_unlink
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sd_setup_read_write_cmnd.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.scsi_alloc_sgtables.sd_setup_read_write_cmnd.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__blk_rq_map_sg.scsi_alloc_sgtables.sd_setup_read_write_cmnd.scsi_queue_rq.blk_mq_dispatch_rq_list
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__blk_rq_map_sg.scsi_alloc_sgtables.sd_setup_read_write_cmnd.scsi_queue_rq
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__blk_rq_map_sg.scsi_alloc_sgtables.sd_setup_read_write_cmnd
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__blk_rq_map_sg.scsi_alloc_sgtables
      0.09 ±223%      +0.2        0.32 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__blk_rq_map_sg
      4.44 ± 12%      +0.2        4.68 ± 12%      +0.1        4.59 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.53 ± 45%      +0.2        0.76 ± 25%      +0.1        0.68 ±  6%  perf-profile.calltrace.cycles-pp.__folio_mark_dirty.filemap_dirty_folio.__set_page_dirty_nobuffers.f2fs_set_data_page_dirty.folio_mark_dirty
      2.86 ± 16%      +0.2        3.10 ± 14%      +0.1        2.93 ± 12%  perf-profile.calltrace.cycles-pp.f2fs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.2        0.24 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.filename_parentat.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.24 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.path_parentat.filename_parentat.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3.65 ± 15%      +0.2        3.90 ± 11%      +0.2        3.85 ± 11%  perf-profile.calltrace.cycles-pp.pagecache_get_page.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      3.53 ± 15%      +0.2        3.78 ± 12%      +0.1        3.63 ± 14%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      0.20 ±143%      +0.3        0.46 ± 73%      +0.2        0.45 ± 50%  perf-profile.calltrace.cycles-pp.rename
      0.00            +0.3        0.26 ±150%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit._printk.f2fs_printk.f2fs_build_node_manager.f2fs_fill_super
      0.00            +0.3        0.26 ±150%      +0.0        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.f2fs_printk.f2fs_build_node_manager
      0.00            +0.3        0.26 ±150%      +0.0        0.00        perf-profile.calltrace.cycles-pp._printk.f2fs_printk.f2fs_build_node_manager.f2fs_fill_super.mount_bdev
      0.00            +0.3        0.26 ±150%      +0.0        0.00        perf-profile.calltrace.cycles-pp.f2fs_printk.f2fs_build_node_manager.f2fs_fill_super.mount_bdev.legacy_get_tree
      0.48 ± 46%      +0.3        0.73 ± 46%      +0.0        0.51 ± 54%  perf-profile.calltrace.cycles-pp.native_io_delay.pit_next_event.clockevents_program_event.hrtimer_interrupt.timer_interrupt
      1.96 ± 12%      +0.3        2.22 ± 29%      +0.2        2.12 ± 14%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.do_fsync.__x64_sys_fsync
      1.08 ±142%      +0.3        1.34 ±142%      -0.4        0.64 ±202%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit._printk
      1.08 ±142%      +0.3        1.34 ±142%      -0.4        0.64 ±202%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      1.94 ± 12%      +0.3        2.20 ± 29%      +0.2        2.11 ± 14%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file.do_fsync
      0.74 ± 12%      +0.3        1.01 ± 29%      +0.0        0.79 ± 16%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio.pagecache_get_page
      1.07 ±142%      +0.3        1.34 ±142%      -0.4        0.64 ±202%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      0.00            +0.3        0.27 ±153%      +0.0        0.00        perf-profile.calltrace.cycles-pp.vt_console_print.console_unlock.vprintk_emit._printk.f2fs_printk
      1.92 ± 12%      +0.3        2.20 ± 29%      +0.2        2.09 ± 15%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.f2fs_do_sync_file
      0.14 ±223%      +0.3        0.42 ±223%      +0.1        0.19 ±225%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.get_page_from_freelist.__alloc_pages.allocate_slab.___slab_alloc
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.get_page_from_freelist.__alloc_pages.allocate_slab
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_page_from_freelist.__alloc_pages
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_page_from_freelist
      0.00            +0.3        0.28 ±100%      +0.2        0.15 ±213%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.3        0.28 ±100%      +0.2        0.15 ±213%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.3        0.28 ±100%      +0.2        0.15 ±213%  perf-profile.calltrace.cycles-pp.execve
      0.00            +0.3        0.28 ±100%      +0.2        0.15 ±213%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.3        0.28 ±100%      +0.2        0.15 ±213%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.14 ±223%      +0.3        0.42 ±223%      +0.0        0.14 ±300%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__raw_callee_save___native_queued_spin_unlock.f2fs_update_dirty_page.f2fs_set_data_page_dirty.folio_mark_dirty
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__raw_callee_save___native_queued_spin_unlock.f2fs_update_dirty_page.f2fs_set_data_page_dirty
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__raw_callee_save___native_queued_spin_unlock.f2fs_update_dirty_page
      0.00            +0.3        0.28 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__raw_callee_save___native_queued_spin_unlock
      1.32 ± 18%      +0.3        1.61 ± 28%      +0.0        1.37 ± 31%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_write_begin
      0.00            +0.3        0.29 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.allocate_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc
      0.00            +0.3        0.29 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.allocate_slab.___slab_alloc.__slab_alloc
      0.00            +0.3        0.29 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc.f2fs_alloc_inode.alloc_inode.new_inode_pseudo
      0.00            +0.3        0.29 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.f2fs_alloc_inode.alloc_inode
      0.00            +0.3        0.29 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc.f2fs_alloc_inode
      0.74 ± 56%      +0.3        1.04 ± 56%      +0.2        0.90 ± 24%  perf-profile.calltrace.cycles-pp.f2fs_new_inode.f2fs_create.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.3        0.30 ±223%      +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug
      0.00            +0.3        0.30 ±223%      +0.1        0.10 ±300%  perf-profile.calltrace.cycles-pp.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug.blk_finish_plug
      1.75 ± 21%      +0.3        2.05 ± 21%      +0.2        1.94 ± 23%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.00            +0.3        0.30 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__raw_callee_save___native_queued_spin_unlock.f2fs_update_dirty_page.f2fs_set_data_page_dirty.folio_mark_dirty.f2fs_write_end
      0.00            +0.3        0.30 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.f2fs_alloc_inode.alloc_inode.new_inode_pseudo.new_inode
      0.00            +0.3        0.30 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.f2fs_alloc_inode.alloc_inode.new_inode_pseudo.new_inode.f2fs_new_inode
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.submit_bio_checks.blk_mq_submit_bio.submit_bio_noacct.submit_bh_wbc
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.submit_bio_checks.blk_mq_submit_bio.submit_bio_noacct
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.submit_bio_checks.blk_mq_submit_bio
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.submit_bio_checks
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.new_inode.f2fs_new_inode.f2fs_create.path_openat.do_filp_open
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.new_inode_pseudo.new_inode.f2fs_new_inode.f2fs_create.path_openat
      0.00            +0.3        0.31 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode_pseudo.new_inode.f2fs_new_inode.f2fs_create
      0.00            +0.3        0.31 ±223%      +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.f2fs_update_dirty_page.f2fs_set_data_page_dirty.folio_mark_dirty.f2fs_write_end.generic_perform_write
      0.00            +0.3        0.32 ±100%      +0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio
      0.10 ±223%      +0.3        0.42 ± 73%      +0.1        0.21 ±122%  perf-profile.calltrace.cycles-pp.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      0.00            +0.3        0.32 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.submit_bio_checks.blk_mq_submit_bio.submit_bio_noacct.submit_bh_wbc.__block_write_full_page
      0.10 ±223%      +0.3        0.43 ± 73%      +0.2        0.33 ± 81%  perf-profile.calltrace.cycles-pp.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      0.11 ±223%      +0.3        0.44 ± 73%      +0.3        0.38 ± 65%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.rename
      0.10 ±223%      +0.3        0.44 ± 74%      +0.3        0.38 ± 65%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      1.42 ±  6%      +0.3        1.77 ± 32%      +0.3        1.69 ± 20%  perf-profile.calltrace.cycles-pp.folio_mark_dirty.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      0.29 ±158%      +0.4        0.64 ± 56%      +0.0        0.31 ±104%  perf-profile.calltrace.cycles-pp.process_simple.perf_session__process_events.record__finish_output.cmd_record.cmd_sched
      0.00            +0.4        0.36 ±155%      +0.3        0.33 ± 82%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.pagecache_get_page
      0.38 ±118%      +0.4        0.74 ± 31%      -0.0        0.33 ±104%  perf-profile.calltrace.cycles-pp.__libc_start_main
      0.38 ±118%      +0.4        0.74 ± 31%      -0.0        0.33 ±104%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      0.38 ±118%      +0.4        0.74 ± 31%      -0.0        0.33 ±104%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      0.08 ±223%      +0.4        0.45 ±109%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.f2fs_printk.f2fs_fill_super.cold.mount_bdev
      0.08 ±223%      +0.4        0.45 ±109%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.f2fs_printk.f2fs_fill_super.cold
      0.08 ±223%      +0.4        0.45 ±109%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp._printk.f2fs_printk.f2fs_fill_super.cold.mount_bdev.legacy_get_tree
      0.08 ±223%      +0.4        0.45 ±109%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.f2fs_fill_super.cold.mount_bdev.legacy_get_tree.vfs_get_tree.path_mount
      0.08 ±223%      +0.4        0.45 ±109%      -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.f2fs_printk.f2fs_fill_super.cold.mount_bdev.legacy_get_tree.vfs_get_tree
      1.23 ±  8%      +0.4        1.61 ± 36%      +0.3        1.54 ± 22%  perf-profile.calltrace.cycles-pp.f2fs_set_data_page_dirty.folio_mark_dirty.f2fs_write_end.generic_perform_write.__generic_file_write_iter
      0.00            +0.4        0.39 ±170%      +0.1        0.10 ±299%  perf-profile.calltrace.cycles-pp.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug.blk_finish_plug.f2fs_write_data_pages
      0.00            +0.4        0.39 ±170%      +0.1        0.11 ±300%  perf-profile.calltrace.cycles-pp.blk_flush_plug.blk_finish_plug.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc
      0.00            +0.4        0.39 ±169%      +0.1        0.11 ±300%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.blk_flush_plug.blk_finish_plug.f2fs_write_data_pages.do_writepages
      0.00            +0.4        0.40 ±106%      +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.drop_caches_sysctl_handler.cold.proc_sys_call_handler.new_sync_write
      0.00            +0.4        0.40 ±106%      +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.drop_caches_sysctl_handler.cold.proc_sys_call_handler
      0.00            +0.4        0.40 ±106%      +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp._printk.drop_caches_sysctl_handler.cold.proc_sys_call_handler.new_sync_write.vfs_write
      0.00            +0.4        0.40 ±106%      +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.drop_caches_sysctl_handler.cold.proc_sys_call_handler.new_sync_write.vfs_write.ksys_write
      0.00            +0.4        0.40 ±170%      +0.1        0.11 ±300%  perf-profile.calltrace.cycles-pp.blk_finish_plug.f2fs_write_data_pages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      1.71 ±  4%      +0.4        2.14 ± 27%      +0.3        2.00 ± 19%  perf-profile.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.29 ±158%      +0.4        0.73 ± 33%      +0.0        0.32 ±104%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record.cmd_sched.run_builtin
      0.29 ±158%      +0.4        0.73 ± 33%      +0.0        0.32 ±104%  perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record.cmd_sched.run_builtin.main
      0.29 ±158%      +0.4        0.73 ± 33%      +0.0        0.32 ±104%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
      0.29 ±158%      +0.4        0.73 ± 33%      +0.0        0.32 ±104%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
      1.17 ± 14%      +0.4        1.61 ± 16%      +0.0        1.18 ± 19%  perf-profile.calltrace.cycles-pp.proc_sys_call_handler.new_sync_write.vfs_write.ksys_write.do_syscall_64
      4.12 ±  3%      +0.4        4.56 ±  8%      +0.1        4.20 ±  4%  perf-profile.calltrace.cycles-pp.update_free_nid_bitmap.f2fs_build_node_manager.f2fs_fill_super.mount_bdev.legacy_get_tree
      3.74 ± 49%      +0.5        4.22 ± 55%      -0.9        2.80 ± 68%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_run
      3.74 ± 49%      +0.5        4.22 ± 55%      -0.9        2.80 ± 68%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_list
      3.74 ± 49%      +0.5        4.22 ± 55%      -0.9        2.80 ± 68%  perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      3.74 ± 49%      +0.5        4.22 ± 55%      -0.9        2.80 ± 68%  perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      3.74 ± 49%      +0.5        4.22 ± 55%      -0.9        2.80 ± 68%  perf-profile.calltrace.cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      0.10 ±223%      +0.5        0.57 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.10 ±223%      +0.5        0.58 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue
      0.00            +0.5        0.49 ± 45%      +0.2        0.15 ±152%  perf-profile.calltrace.cycles-pp.f2fs_build_segment_manager.f2fs_fill_super.mount_bdev.legacy_get_tree.vfs_get_tree
      0.10 ±223%      +0.5        0.60 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue
      0.10 ±223%      +0.5        0.62 ±223%      -0.0        0.10 ±300%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests
      0.10 ±223%      +0.5        0.62 ±223%      -0.0        0.10 ±300%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list
      0.46 ±155%      +0.5        1.00 ±103%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__block_write_full_page.__writepage.write_cache_pages.generic_writepages.do_writepages
      0.46 ±155%      +0.5        1.00 ±104%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__writepage.write_cache_pages.generic_writepages.do_writepages.filemap_fdatawrite_wbc
      0.11 ±223%      +0.6        0.67 ±141%      -0.1        0.00        perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bh_wbc.__block_write_full_page.__writepage.write_cache_pages
      0.11 ±223%      +0.6        0.67 ±141%      -0.1        0.00        perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct.submit_bh_wbc.__block_write_full_page.__writepage
      3.46 ± 22%      +0.6        4.02 ± 21%      +0.3        3.77 ± 20%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.46 ± 22%      +0.6        4.03 ± 21%      +0.3        3.78 ± 20%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.47 ± 22%      +0.6        4.04 ± 22%      +0.3        3.79 ± 20%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.68 ± 18%      +0.6        2.26 ± 29%      +0.1        1.79 ± 24%  perf-profile.calltrace.cycles-pp.pit_next_event.clockevents_program_event.hrtimer_interrupt.timer_interrupt.__handle_irq_event_percpu
      0.12 ±223%      +0.6        0.70 ±141%      -0.1        0.00        perf-profile.calltrace.cycles-pp.submit_bh_wbc.__block_write_full_page.__writepage.write_cache_pages.generic_writepages
      1.68 ± 18%      +0.6        2.26 ± 29%      +0.1        1.79 ± 24%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.timer_interrupt.__handle_irq_event_percpu.handle_irq_event_percpu
      0.65 ±145%      +0.6        1.30 ±117%      -0.2        0.48 ±217%  perf-profile.calltrace.cycles-pp.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll
      0.63 ±144%      +0.7        1.28 ±117%      -0.1        0.48 ±218%  perf-profile.calltrace.cycles-pp.cfb_imageblit.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll
      5.54 ±  8%      +0.7        6.21 ±  7%      +0.5        6.05 ±  8%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      5.24 ±  8%      +0.7        5.91 ±  7%      +0.5        5.76 ±  9%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      3.06 ±  9%      +0.7        3.74 ± 28%      -0.0        3.06 ± 15%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      3.61 ± 20%      +0.7        4.28 ± 21%      +0.4        4.04 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.61 ± 20%      +0.7        4.28 ± 21%      +0.4        4.04 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.47 ±154%      +0.7        1.15 ± 88%      -0.5        0.00        perf-profile.calltrace.cycles-pp.file_write_and_wait_range.blkdev_fsync.do_fsync.__x64_sys_fsync.do_syscall_64
      0.47 ±154%      +0.7        1.15 ± 88%      -0.5        0.00        perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.blkdev_fsync.do_fsync
      0.47 ±154%      +0.7        1.15 ± 88%      -0.5        0.00        perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.file_write_and_wait_range.blkdev_fsync.do_fsync.__x64_sys_fsync
      0.47 ±154%      +0.7        1.15 ± 88%      -0.5        0.00        perf-profile.calltrace.cycles-pp.blkdev_fsync.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.47 ±154%      +0.7        1.15 ± 88%      -0.5        0.00        perf-profile.calltrace.cycles-pp.generic_writepages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range.blkdev_fsync
      0.47 ±154%      +0.7        1.15 ± 88%      -0.5        0.00        perf-profile.calltrace.cycles-pp.write_cache_pages.generic_writepages.do_writepages.filemap_fdatawrite_wbc.file_write_and_wait_range
      3.04 ±  9%      +0.7        3.72 ± 28%      -0.0        3.04 ± 15%  perf-profile.calltrace.cycles-pp.handle_level_irq.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.78 ±149%      +0.7        1.46 ±109%      -0.2        0.61 ±180%  perf-profile.calltrace.cycles-pp.vt_console_print.console_unlock.vprintk_emit._printk.irq_work_single
      3.62 ± 20%      +0.7        4.31 ± 20%      +0.5        4.08 ± 19%  perf-profile.calltrace.cycles-pp.write
      2.04 ±  8%      +0.7        2.73 ± 26%      +0.1        2.10 ± 25%  perf-profile.calltrace.cycles-pp.timer_interrupt.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_level_irq
      2.04 ±  7%      +0.7        2.73 ± 26%      +0.1        2.09 ± 25%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.timer_interrupt.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event
      5.63 ± 14%      +0.7        6.32 ±  8%      +0.2        5.86 ± 10%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter
      2.07 ±  7%      +0.7        2.76 ± 27%      +0.0        2.11 ± 25%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_level_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      2.05 ±  8%      +0.7        2.74 ± 26%      +0.1        2.10 ± 25%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_level_irq.__common_interrupt
      2.07 ±  8%      +0.7        2.76 ± 27%      +0.0        2.11 ± 25%  perf-profile.calltrace.cycles-pp.handle_irq_event_percpu.handle_irq_event.handle_level_irq.__common_interrupt.common_interrupt
      0.17 ±223%      +0.7        0.87 ± 72%      -0.1        0.11 ±299%  perf-profile.calltrace.cycles-pp.__irqentry_text_start.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.65 ±145%      +0.7        1.39 ±119%      -0.2        0.49 ±217%  perf-profile.calltrace.cycles-pp.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll.lf
      0.65 ±145%      +0.8        1.48 ±112%      -0.2        0.49 ±217%  perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
      4.47 ±  2%      +0.8        5.30 ± 10%      +0.3        4.73 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_build_node_manager.f2fs_fill_super.mount_bdev.legacy_get_tree.vfs_get_tree
      4.97 ±  2%      +1.0        5.93 ±  9%      +0.3        5.24 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_fill_super.mount_bdev.legacy_get_tree.vfs_get_tree.path_mount
      0.76 ±150%      +1.0        1.72 ±113%      -0.2        0.61 ±180%  perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_unlock.vprintk_emit._printk
      0.76 ±150%      +1.0        1.81 ±114%      -0.2        0.61 ±180%  perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.console_unlock.vprintk_emit
      0.76 ±150%      +1.0        1.81 ±114%      -0.2        0.61 ±180%  perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.console_unlock
      3.40 ± 10%      +1.1        4.50 ± 26%      +0.1        3.54 ± 15%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      3.40 ± 10%      +1.1        4.50 ± 26%      +0.1        3.53 ± 15%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
     15.92 ±  6%      +1.1       17.06 ±  4%      +1.4       17.28 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64.do_syscall_64
      4.33 ± 12%      +1.2        5.49 ± 20%      -0.0        4.30 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
     15.96 ±  6%      +1.2       17.15 ±  4%      +1.4       17.33 ±  6%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.52 ±  5%      +1.2       17.74 ±  4%      +1.4       17.89 ±  5%  perf-profile.calltrace.cycles-pp.__libc_pwrite
     16.22 ±  6%      +1.2       17.47 ±  4%      +1.4       17.62 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     16.07 ±  6%      +1.2       17.32 ±  4%      +1.4       17.48 ±  6%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     16.26 ±  6%      +1.3       17.51 ±  4%      +1.4       17.66 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     16.12 ±  6%      +1.3       17.38 ±  4%      +1.4       17.54 ±  6%  perf-profile.calltrace.cycles-pp.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     13.13 ±  7%      +1.3       14.42 ±  5%      +1.2       14.30 ±  7%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write
      4.76 ± 10%      +1.3        6.04 ± 20%      -0.1        4.68 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
     13.30 ±  7%      +1.3       14.62 ±  5%      +1.2       14.51 ±  7%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe.mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.do_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe.mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.path_mount.do_mount.__x64_sys_mount.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.vfs_get_tree.path_mount.do_mount.__x64_sys_mount.do_syscall_64
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.legacy_get_tree.vfs_get_tree.path_mount.do_mount.__x64_sys_mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.calltrace.cycles-pp.mount_bdev.legacy_get_tree.vfs_get_tree.path_mount.do_mount
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      6.79 ± 10%      -2.0        4.74 ± 11%      -0.3        6.52 ± 13%  perf-profile.children.cycles-pp.__schedule
      5.24 ±  6%      -1.8        3.47 ± 17%      -0.1        5.10 ± 10%  perf-profile.children.cycles-pp.kthread
      5.25 ±  6%      -1.8        3.49 ± 17%      -0.1        5.12 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      7.17 ±  5%      -1.6        5.57 ± 17%      -0.3        6.90 ± 14%  perf-profile.children.cycles-pp.perf_tp_event
      6.98 ±  5%      -1.6        5.40 ± 17%      -0.3        6.66 ± 13%  perf-profile.children.cycles-pp.perf_swevent_overflow
      6.93 ±  5%      -1.6        5.36 ± 17%      -0.3        6.62 ± 13%  perf-profile.children.cycles-pp.__perf_event_overflow
      6.88 ±  5%      -1.6        5.32 ± 17%      -0.3        6.54 ± 13%  perf-profile.children.cycles-pp.perf_event_output_forward
      5.87 ±  5%      -1.4        4.52 ± 17%      -0.4        5.46 ± 14%  perf-profile.children.cycles-pp.perf_prepare_sample
      5.60 ±  6%      -1.3        4.26 ± 18%      -0.5        5.13 ± 14%  perf-profile.children.cycles-pp.perf_callchain
      5.56 ±  6%      -1.3        4.23 ± 18%      -0.5        5.08 ± 14%  perf-profile.children.cycles-pp.get_perf_callchain
      5.35 ±  9%      -1.3        4.06 ± 12%      -0.3        5.07 ± 17%  perf-profile.children.cycles-pp.schedule
      4.65 ±  5%      -1.1        3.55 ± 20%      -0.3        4.30 ± 15%  perf-profile.children.cycles-pp.perf_callchain_kernel
      1.10 ±  9%      -1.1        0.01 ±223%      -1.0        0.10 ±204%  perf-profile.children.cycles-pp.mod_delayed_work_on
      1.58 ±  6%      -1.1        0.51 ± 24%      -0.1        1.50 ± 10%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      5.34 ± 10%      -1.0        4.36 ± 26%      +0.1        5.44 ± 16%  perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      2.00 ± 11%      -0.9        1.09 ± 19%      -0.1        1.91 ± 12%  perf-profile.children.cycles-pp.__cond_resched
      1.70 ± 15%      -0.9        0.80 ± 34%      -0.0        1.65 ± 18%  perf-profile.children.cycles-pp.worker_thread
      1.50 ± 14%      -0.9        0.62 ± 30%      -0.1        1.41 ± 13%  perf-profile.children.cycles-pp.preempt_schedule_common
      3.72 ±  4%      -0.9        2.85 ± 18%      -0.4        3.36 ± 16%  perf-profile.children.cycles-pp.unwind_next_frame
      9.48 ±  9%      -0.9        8.62 ±  9%      -0.0        9.47 ± 10%  perf-profile.children.cycles-pp.f2fs_do_sync_file
      1.12 ±  9%      -0.8        0.31 ± 29%      -1.1        0.04 ± 84%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      3.44 ±  7%      -0.8        2.66 ± 21%      -0.1        3.30 ± 20%  perf-profile.children.cycles-pp.update_curr
      3.80 ±  3%      -0.8        3.04 ± 16%      -0.2        3.60 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
     13.98 ±  6%      -0.8       13.22 ± 17%      -0.8       13.22 ± 10%  perf-profile.children.cycles-pp.asm_common_interrupt
      3.21 ±  6%      -0.7        2.47 ± 24%      -0.2        3.02 ± 19%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
     13.79 ±  5%      -0.7       13.09 ± 17%      -0.7       13.05 ± 10%  perf-profile.children.cycles-pp.common_interrupt
      6.16 ± 22%      -0.7        5.50 ±  7%      -0.9        5.29 ±  4%  perf-profile.children.cycles-pp.filemap_read
      7.71 ± 11%      -0.7        7.06 ±  8%      -0.4        7.34 ±  6%  perf-profile.children.cycles-pp.__xstat64
      4.81 ± 12%      -0.7        4.15 ± 17%      -0.4        4.43 ±  9%  perf-profile.children.cycles-pp.unlink
      3.35 ± 17%      -0.6        2.70 ± 11%      -0.4        2.95 ±  8%  perf-profile.children.cycles-pp.evict
      6.80 ± 20%      -0.6        6.16 ±  7%      -0.9        5.86 ±  3%  perf-profile.children.cycles-pp.new_sync_read
      1.02 ±  6%      -0.6        0.39 ± 33%      -0.2        0.81 ±  8%  perf-profile.children.cycles-pp.__queue_work
      3.26 ± 17%      -0.6        2.65 ± 12%      -0.4        2.84 ±  8%  perf-profile.children.cycles-pp.f2fs_evict_inode
      4.62 ± 13%      -0.6        4.02 ± 18%      -0.4        4.22 ± 10%  perf-profile.children.cycles-pp.do_unlinkat
      4.68 ± 13%      -0.6        4.07 ± 18%      -0.4        4.27 ±  9%  perf-profile.children.cycles-pp.__x64_sys_unlink
      6.89 ± 13%      -0.6        6.30 ±  8%      -0.4        6.50 ±  5%  perf-profile.children.cycles-pp.__do_sys_newstat
      5.31 ± 18%      -0.6        4.72 ±  9%      -0.3        4.98 ±  6%  perf-profile.children.cycles-pp.filename_lookup
      6.59 ± 13%      -0.6        6.01 ±  8%      -0.4        6.23 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.90 ±  9%      -0.6        0.33 ± 30%      -0.1        0.77 ±  9%  perf-profile.children.cycles-pp.__submit_merged_bio
      0.65 ± 12%      -0.6        0.10 ± 85%      -0.2        0.50 ± 16%  perf-profile.children.cycles-pp.blk_mq_sched_insert_request
      6.33 ± 13%      -0.6        5.78 ± 10%      -0.3        6.08 ±  5%  perf-profile.children.cycles-pp.user_path_at_empty
      5.12 ± 18%      -0.5        4.58 ±  9%      -0.3        4.81 ±  7%  perf-profile.children.cycles-pp.path_lookupat
      0.83 ± 62%      -0.5        0.29 ±177%      +0.0        0.88 ± 77%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      4.67 ± 17%      -0.5        4.14 ± 21%      -0.2        4.49 ± 11%  perf-profile.children.cycles-pp.__softirqentry_text_start
      2.12 ± 15%      -0.5        1.59 ± 16%      -0.0        2.09 ± 14%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      1.94 ± 11%      -0.5        1.42 ± 13%      -0.2        1.79 ± 26%  perf-profile.children.cycles-pp.dequeue_task_fair
      7.26 ± 18%      -0.5        6.76 ±  8%      -1.0        6.22 ±  3%  perf-profile.children.cycles-pp.vfs_read
      4.90 ± 25%      -0.5        4.40 ±  8%      -0.7        4.18 ±  4%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.81 ± 23%      -0.5        0.32 ± 25%      +0.2        0.97 ± 12%  perf-profile.children.cycles-pp.down_read
      1.12 ± 25%      -0.5        0.63 ± 14%      -0.2        0.95 ± 23%  perf-profile.children.cycles-pp.finish_task_switch
      1.72 ± 38%      -0.5        1.24 ± 12%      -0.4        1.30 ± 17%  perf-profile.children.cycles-pp.asm_exc_page_fault
      4.55 ± 27%      -0.5        4.08 ±  8%      -0.7        3.81 ±  4%  perf-profile.children.cycles-pp.copyout
      6.51 ± 12%      -0.5        6.04 ±  6%      -0.7        5.83 ±  4%  perf-profile.children.cycles-pp.__libc_pread
      1.21 ± 17%      -0.5        0.74 ± 21%      -0.0        1.19 ± 11%  perf-profile.children.cycles-pp.handle_edge_irq
      5.77 ± 13%      -0.4        5.32 ±  7%      -0.6        5.15 ±  4%  perf-profile.children.cycles-pp.f2fs_file_read_iter
      1.82 ± 11%      -0.4        1.37 ± 15%      -0.1        1.69 ± 26%  perf-profile.children.cycles-pp.dequeue_entity
      6.04 ± 12%      -0.4        5.60 ±  7%      -0.6        5.43 ±  4%  perf-profile.children.cycles-pp.ksys_pread64
      1.61 ±  9%      -0.4        1.17 ± 20%      -0.2        1.39 ± 20%  perf-profile.children.cycles-pp.__orc_find
      1.10 ± 16%      -0.4        0.68 ± 22%      -0.0        1.08 ± 11%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      3.87 ± 22%      -0.4        3.46 ± 25%      -0.2        3.64 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      2.06 ±  5%      -0.4        1.66 ± 15%      -0.1        2.01 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      4.54 ± 19%      -0.4        4.14 ± 12%      -0.3        4.23 ± 12%  perf-profile.children.cycles-pp.walk_component
      0.84 ± 48%      -0.4        0.46 ± 77%      +0.0        0.85 ± 59%  perf-profile.children.cycles-pp.__write_checkpoint_sync
      0.84 ± 48%      -0.4        0.46 ± 77%      +0.0        0.85 ± 59%  perf-profile.children.cycles-pp.f2fs_write_checkpoint
      0.84 ± 48%      -0.4        0.46 ± 75%      +0.0        0.85 ± 59%  perf-profile.children.cycles-pp.__checkpoint_and_complete_reqs
      0.84 ± 48%      -0.4        0.46 ± 75%      +0.0        0.85 ± 59%  perf-profile.children.cycles-pp.issue_checkpoint_thread
      0.80 ± 50%      -0.4        0.43 ± 84%      +0.0        0.80 ± 61%  perf-profile.children.cycles-pp.block_operations
      0.84 ± 14%      -0.4        0.47 ± 30%      -0.0        0.82 ± 12%  perf-profile.children.cycles-pp.ahci_handle_port_intr
      0.70 ± 49%      -0.4        0.34 ± 94%      +0.0        0.74 ± 56%  perf-profile.children.cycles-pp.wake_up_q
      1.33 ± 50%      -0.4        0.96 ± 14%      -0.4        0.97 ± 22%  perf-profile.children.cycles-pp.exc_page_fault
      0.66 ± 51%      -0.4        0.31 ±110%      +0.0        0.71 ± 60%  perf-profile.children.cycles-pp.rwsem_wake
     10.45 ±  8%      -0.3       10.11 ± 10%      -0.3       10.10 ±  9%  perf-profile.children.cycles-pp.fsync
      0.95 ± 14%      -0.3        0.62 ± 18%      +0.1        1.04 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
     10.27 ±  9%      -0.3        9.96 ± 11%      -0.3        9.93 ±  9%  perf-profile.children.cycles-pp.__x64_sys_fsync
     10.26 ±  9%      -0.3        9.95 ± 11%      -0.3        9.92 ±  9%  perf-profile.children.cycles-pp.do_fsync
      0.54 ±108%      -0.3        0.23 ± 12%      -0.3        0.29 ± 31%  perf-profile.children.cycles-pp.folio_mapping
     10.10 ±  2%      -0.3        9.80 ± 19%      -0.6        9.52 ± 11%  perf-profile.children.cycles-pp.__common_interrupt
      1.63 ±  6%      -0.3        1.34 ± 27%      -0.2        1.42 ± 12%  perf-profile.children.cycles-pp.__unwind_start
      0.31 ± 19%      -0.3        0.02 ±142%      -0.0        0.27 ± 10%  perf-profile.children.cycles-pp.__blk_mq_free_request
      0.70 ± 16%      -0.3        0.41 ± 53%      -0.0        0.66 ± 18%  perf-profile.children.cycles-pp.process_one_work
      0.39 ±161%      -0.3        0.11 ± 59%      -0.0        0.35 ±159%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.44 ±141%      -0.3        0.16 ± 32%      -0.0        0.40 ±140%  perf-profile.children.cycles-pp.__block_write_begin_int
      0.40 ±157%      -0.3        0.13 ± 54%      -0.0        0.36 ±157%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.40 ±156%      -0.3        0.14 ± 55%      -0.0        0.37 ±149%  perf-profile.children.cycles-pp.create_empty_buffers
      0.91 ± 10%      -0.3        0.65 ± 21%      -0.2        0.70 ± 12%  perf-profile.children.cycles-pp.issue_flush_thread
      0.41 ±151%      -0.3        0.15 ± 36%      -0.0        0.38 ±148%  perf-profile.children.cycles-pp.create_page_buffers
      1.36 ± 42%      -0.3        1.10 ± 13%      -0.5        0.91 ± 10%  perf-profile.children.cycles-pp.read
      1.10 ± 56%      -0.3        0.85 ± 16%      -0.3        0.80 ± 25%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.08 ± 58%      -0.3        0.82 ± 10%      -0.2        0.90 ± 15%  perf-profile.children.cycles-pp.__lookup_slow
      0.87 ± 65%      -0.2        0.62 ±  9%      -0.3        0.61 ± 17%  perf-profile.children.cycles-pp.f2fs_find_in_inline_dir
      0.58 ± 13%      -0.2        0.34 ± 26%      -0.0        0.56 ± 17%  perf-profile.children.cycles-pp.ahci_handle_port_interrupt
      0.90 ± 65%      -0.2        0.65 ± 12%      -0.3        0.64 ± 17%  perf-profile.children.cycles-pp.__f2fs_find_entry
      0.80 ± 19%      -0.2        0.56 ± 23%      -0.1        0.66 ± 18%  perf-profile.children.cycles-pp.submit_bio_wait
      0.82 ± 19%      -0.2        0.57 ± 24%      -0.1        0.68 ± 16%  perf-profile.children.cycles-pp.blkdev_issue_flush
      0.57 ± 17%      -0.2        0.33 ± 24%      +0.1        0.64 ± 18%  perf-profile.children.cycles-pp.put_prev_entity
      0.82 ± 19%      -0.2        0.58 ± 24%      -0.1        0.68 ± 16%  perf-profile.children.cycles-pp.__submit_flush_wait
      0.37 ± 24%      -0.2        0.13 ± 61%      -0.0        0.35 ± 47%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.75 ± 15%      -0.2        0.51 ± 12%      -0.1        0.69 ± 26%  perf-profile.children.cycles-pp.__write_node_page
      0.80 ± 53%      -0.2        0.57 ± 14%      -0.1        0.67 ± 15%  perf-profile.children.cycles-pp.__radix_tree_lookup
      1.93 ±  8%      -0.2        1.70 ±  9%      -0.1        1.84 ±  7%  perf-profile.children.cycles-pp.__fxstat64
      0.64 ± 92%      -0.2        0.41 ± 17%      -0.2        0.40 ± 23%  perf-profile.children.cycles-pp.f2fs_find_target_dentry
      1.19 ±  5%      -0.2        0.96 ±  9%      +0.0        1.21 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.83 ± 11%      -0.2        0.61 ± 11%      -0.1        0.77 ± 14%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.39 ± 22%      -0.2        0.17 ± 27%      -0.1        0.34 ± 36%  perf-profile.children.cycles-pp.blk_flush_complete_seq
      1.21 ±  6%      -0.2        0.99 ± 14%      +0.1        1.36 ± 15%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
      0.63 ± 25%      -0.2        0.41 ± 14%      -0.1        0.56 ± 20%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.76 ± 16%      -0.2        0.54 ± 22%      -0.1        0.62 ± 18%  perf-profile.children.cycles-pp.perf_callchain_user
      0.96 ± 22%      -0.2        0.74 ± 17%      -0.1        0.86 ± 20%  perf-profile.children.cycles-pp.orc_find
     10.55 ±  6%      -0.2       10.33 ±  7%      -0.1       10.46 ±  4%  perf-profile.children.cycles-pp.do_sys_openat2
      0.41 ± 20%      -0.2        0.20 ± 33%      -0.1        0.35 ± 36%  perf-profile.children.cycles-pp.flush_end_io
     10.59 ±  6%      -0.2       10.38 ±  6%      -0.1       10.53 ±  4%  perf-profile.children.cycles-pp.do_sys_open
      0.72 ± 19%      -0.2        0.51 ± 22%      -0.1        0.59 ± 17%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.28 ±146%      -0.2        0.08 ± 71%      -0.2        0.06 ± 72%  perf-profile.children.cycles-pp.radix_tree_delete_item
      0.84 ± 75%      -0.2        0.64 ±  8%      -0.2        0.65 ± 22%  perf-profile.children.cycles-pp.f2fs_lookup
      4.73 ±  5%      -0.2        4.52 ± 11%      -0.2        4.58 ±  7%  perf-profile.children.cycles-pp.__open64_nocancel
      0.43 ± 36%      -0.2        0.24 ± 72%      -0.0        0.41 ± 58%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.30 ± 98%      -0.2        0.11 ± 57%      -0.2        0.13 ± 63%  perf-profile.children.cycles-pp.vfs_mkdir
      0.30 ± 98%      -0.2        0.11 ± 57%      -0.2        0.12 ± 64%  perf-profile.children.cycles-pp.f2fs_mkdir
      0.35 ± 83%      -0.2        0.16 ± 41%      -0.2        0.18 ± 44%  perf-profile.children.cycles-pp.do_mkdirat
      2.83 ±  4%      -0.2        2.64 ± 22%      -0.3        2.48 ± 16%  perf-profile.children.cycles-pp.mask_and_ack_8259A
      0.54 ± 25%      -0.2        0.35 ± 14%      -0.1        0.47 ± 22%  perf-profile.children.cycles-pp.__kernel_text_address
      0.86 ± 11%      -0.2        0.68 ± 26%      +0.0        0.90 ± 16%  perf-profile.children.cycles-pp.f2fs_convert_inline_page
      1.56 ± 13%      -0.2        1.37 ± 62%      -0.3        1.28 ± 11%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      4.27 ±  6%      -0.2        4.09 ±  7%      +0.2        4.45 ±  8%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.36 ± 82%      -0.2        0.17 ± 33%      -0.2        0.20 ± 41%  perf-profile.children.cycles-pp.mkdir
      0.81 ± 20%      -0.2        0.62 ± 30%      -0.0        0.76 ±  7%  perf-profile.children.cycles-pp.f2fs_issue_flush
      0.35 ± 83%      -0.2        0.17 ± 34%      -0.2        0.19 ± 45%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      1.58 ± 13%      -0.2        1.40 ± 60%      -0.3        1.31 ± 11%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.30 ± 96%      -0.2        0.12 ± 30%      -0.1        0.15 ± 38%  perf-profile.children.cycles-pp.common_file_perm
      0.40 ± 40%      -0.2        0.23 ± 74%      -0.0        0.40 ± 58%  perf-profile.children.cycles-pp.check_preempt_curr
      2.04 ±  4%      -0.2        1.88 ± 22%      +0.2        2.20 ±  8%  perf-profile.children.cycles-pp.f2fs_preallocate_blocks
      0.17 ±223%      -0.2        0.00            -0.2        0.01 ±300%  perf-profile.children.cycles-pp.ns_get_path_cb
      0.17 ±223%      -0.2        0.00            -0.2        0.01 ±300%  perf-profile.children.cycles-pp.__ns_get_path
      0.17 ±223%      -0.2        0.00            -0.2        0.02 ±207%  perf-profile.children.cycles-pp.ns_get_path
      0.17 ±223%      -0.2        0.00            -0.1        0.02 ±162%  perf-profile.children.cycles-pp.proc_ns_get_link
      0.38 ± 40%      -0.2        0.22 ± 80%      -0.0        0.36 ± 66%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.92 ± 42%      -0.2        0.75 ± 58%      -0.2        0.66 ± 15%  perf-profile.children.cycles-pp.truncate_node
      1.24 ± 10%      -0.2        1.08 ± 24%      +0.2        1.40 ± 35%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.48 ± 17%      -0.2        0.32 ± 21%      -0.0        0.46 ± 31%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      0.92 ±  6%      -0.2        0.76 ± 11%      +0.0        0.95 ±  9%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.00 ± 36%      -0.2        0.84 ± 53%      -0.2        0.75 ± 14%  perf-profile.children.cycles-pp.f2fs_remove_inode_page
      0.47 ± 30%      -0.2        0.32 ± 18%      -0.0        0.43 ± 22%  perf-profile.children.cycles-pp.kernel_text_address
      1.22 ±  8%      -0.1        1.07 ± 10%      -0.1        1.12 ± 10%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.50 ± 14%      -0.1        0.35 ± 37%      -0.1        0.42 ± 11%  perf-profile.children.cycles-pp.wait_for_completion
      0.20 ±188%      -0.1        0.05 ± 74%      -0.1        0.10 ±141%  perf-profile.children.cycles-pp.pick_link
      1.68 ±  9%      -0.1        1.54 ±  8%      +0.0        1.69 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.38 ± 70%      -0.1        0.24 ± 14%      -0.2        0.23 ± 38%  perf-profile.children.cycles-pp.security_file_permission
      3.33 ±  8%      -0.1        3.19 ±  7%      +0.0        3.37 ± 10%  perf-profile.children.cycles-pp.f2fs_read_inline_dir
      0.43 ± 13%      -0.1        0.28 ± 26%      +0.0        0.44 ± 28%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
      0.68 ± 91%      -0.1        0.54 ± 47%      +0.1        0.80 ± 71%  perf-profile.children.cycles-pp.block_write_begin
      1.00 ± 21%      -0.1        0.86 ± 24%      -0.1        0.86 ± 17%  perf-profile.children.cycles-pp.unmask_irq
      0.76 ± 18%      -0.1        0.62 ± 27%      +0.0        0.76 ± 16%  perf-profile.children.cycles-pp.memcpy_erms
      1.04 ± 14%      -0.1        0.91 ± 38%      +0.0        1.06 ± 15%  perf-profile.children.cycles-pp.do_write_page
      0.91 ± 12%      -0.1        0.77 ± 10%      -0.1        0.83 ± 19%  perf-profile.children.cycles-pp.xa_load
      1.00 ± 15%      -0.1        0.86 ±  9%      -0.0        0.95 ± 18%  perf-profile.children.cycles-pp.f2fs_ra_node_page
      0.98 ± 21%      -0.1        0.85 ± 25%      -0.1        0.85 ± 17%  perf-profile.children.cycles-pp.unmask_8259A_irq
      1.85 ±  6%      -0.1        1.72 ±  9%      +0.1        1.97 ± 19%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.26 ±136%      -0.1        0.13 ± 19%      -0.2        0.08 ± 41%  perf-profile.children.cycles-pp.__remove_ino_entry
      1.53 ±  9%      -0.1        1.40 ± 10%      -0.1        1.44 ±  9%  perf-profile.children.cycles-pp.inode_permission
      0.36 ± 98%      -0.1        0.23 ± 32%      -0.1        0.26 ± 42%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.65 ± 11%      -0.1        0.52 ± 11%      -0.1        0.59 ± 16%  perf-profile.children.cycles-pp.do_dentry_open
      1.75 ± 10%      -0.1        1.62 ±  8%      -0.1        1.62 ±  9%  perf-profile.children.cycles-pp.xas_load
      0.75 ± 11%      -0.1        0.62 ± 25%      -0.0        0.75 ± 18%  perf-profile.children.cycles-pp.f2fs_unlink
      0.86 ± 11%      -0.1        0.74 ± 18%      -0.0        0.84 ± 18%  perf-profile.children.cycles-pp.vfs_unlink
      0.44 ± 15%      -0.1        0.32 ± 24%      -0.1        0.35 ± 21%  perf-profile.children.cycles-pp.wait_for_completion_io_timeout
      0.80 ± 14%      -0.1        0.68 ± 23%      +0.0        0.84 ± 14%  perf-profile.children.cycles-pp.perf_output_sample
      0.41 ± 79%      -0.1        0.29 ± 29%      -0.1        0.32 ± 35%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.76 ± 15%      -0.1        0.64 ± 20%      -0.0        0.71 ± 11%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.86 ± 19%      -0.1        0.75 ± 15%      -0.0        0.86 ± 12%  perf-profile.children.cycles-pp.schedule_timeout
      0.26 ± 35%      -0.1        0.15 ± 64%      -0.0        0.24 ± 39%  perf-profile.children.cycles-pp.__module_address
      0.32 ±108%      -0.1        0.21 ± 31%      -0.1        0.24 ± 49%  perf-profile.children.cycles-pp.nsinfo__new
      0.32 ±106%      -0.1        0.22 ± 33%      -0.1        0.25 ± 47%  perf-profile.children.cycles-pp.thread__new
      0.29 ± 23%      -0.1        0.18 ± 38%      -0.1        0.24 ± 21%  perf-profile.children.cycles-pp.blk_insert_flush
      0.38 ± 17%      -0.1        0.27 ±  5%      -0.0        0.38 ± 14%  perf-profile.children.cycles-pp.__mod_lruvec_state
      2.70 ±  7%      -0.1        2.59 ±  9%      +0.0        2.70 ± 11%  perf-profile.children.cycles-pp.f2fs_fill_dentries
      0.20 ± 25%      -0.1        0.09 ± 84%      -0.0        0.18 ± 36%  perf-profile.children.cycles-pp.is_module_text_address
      3.43 ±  9%      -0.1        3.32 ±  8%      +0.1        3.51 ± 10%  perf-profile.children.cycles-pp.f2fs_readdir
      0.19 ± 22%      -0.1        0.08 ± 82%      -0.0        0.17 ± 40%  perf-profile.children.cycles-pp.__module_text_address
      0.26 ± 20%      -0.1        0.15 ± 25%      -0.0        0.25 ± 50%  perf-profile.children.cycles-pp.blk_mq_end_request
      0.29 ±101%      -0.1        0.18 ± 35%      -0.1        0.16 ± 33%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.42 ± 16%      -0.1        0.32 ± 31%      -0.1        0.35 ± 13%  perf-profile.children.cycles-pp.path_init
      3.28 ±  7%      -0.1        3.18 ±  8%      +0.3        3.54 ±  9%  perf-profile.children.cycles-pp.kill
      0.46 ± 12%      -0.1        0.36 ± 20%      -0.0        0.41 ± 17%  perf-profile.children.cycles-pp.aa_may_signal
      1.13 ± 17%      -0.1        1.02 ±  4%      +0.0        1.14 ± 14%  perf-profile.children.cycles-pp.kmem_cache_free
      2.08 ±  9%      -0.1        1.98 ± 14%      +0.0        2.13 ± 20%  perf-profile.children.cycles-pp.lookup_fast
      0.52 ±113%      -0.1        0.42 ±102%      -0.3        0.27 ± 19%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.70 ± 23%      -0.1        0.60 ±  9%      -0.1        0.62 ± 17%  perf-profile.children.cycles-pp.f2fs_truncate
      1.53 ±  4%      -0.1        1.42 ± 18%      +0.0        1.56 ± 16%  perf-profile.children.cycles-pp.__get_node_page
      0.18 ± 21%      -0.1        0.08 ± 81%      -0.0        0.14 ± 28%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.36 ± 17%      -0.1        0.26 ± 24%      -0.1        0.29 ± 22%  perf-profile.children.cycles-pp.set_node_addr
      0.58 ± 10%      -0.1        0.49 ± 18%      -0.0        0.56 ± 15%  perf-profile.children.cycles-pp.apparmor_task_kill
      3.98 ±  8%      -0.1        3.88 ±  6%      +0.2        4.17 ±  9%  perf-profile.children.cycles-pp.iterate_dir
      0.73 ± 12%      -0.1        0.64 ± 12%      -0.1        0.68 ±  9%  perf-profile.children.cycles-pp.cp_new_stat
      0.26 ±109%      -0.1        0.17 ± 33%      -0.1        0.16 ± 40%  perf-profile.children.cycles-pp.clear_page_erms
      0.26 ±109%      -0.1        0.17 ± 33%      -0.1        0.16 ± 39%  perf-profile.children.cycles-pp.kernel_init_free_pages
      0.39 ± 23%      -0.1        0.30 ± 21%      -0.0        0.34 ± 30%  perf-profile.children.cycles-pp.complete
      0.70 ± 14%      -0.1        0.62 ± 17%      -0.1        0.62 ± 14%  perf-profile.children.cycles-pp.vfs_fstat
      1.58 ± 12%      -0.1        1.49 ± 15%      +0.1        1.71 ± 20%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.19 ± 34%      -0.1        0.10 ± 41%      +0.0        0.20 ± 26%  perf-profile.children.cycles-pp.sata_async_notification
      0.68 ± 23%      -0.1        0.60 ±  9%      -0.1        0.61 ± 16%  perf-profile.children.cycles-pp.f2fs_do_truncate_blocks
      0.56 ± 18%      -0.1        0.48 ± 22%      +0.0        0.60 ± 16%  perf-profile.children.cycles-pp.perf_output_copy
      0.30 ± 18%      -0.1        0.21 ± 50%      -0.1        0.23 ± 24%  perf-profile.children.cycles-pp.nd_jump_root
      0.18 ± 34%      -0.1        0.10 ± 38%      +0.0        0.19 ± 28%  perf-profile.children.cycles-pp.ahci_scr_read
      2.76 ± 19%      -0.1        2.68 ± 22%      +0.1        2.81 ± 19%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.16 ± 12%      -0.1        0.08 ± 80%      +0.0        0.18 ± 23%  perf-profile.children.cycles-pp.__list_add_valid
      0.14 ± 14%      -0.1        0.06 ±101%      -0.0        0.11 ± 41%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.27 ±109%      -0.1        0.19 ± 15%      -0.1        0.16 ± 35%  perf-profile.children.cycles-pp.do_anonymous_page
      0.27 ±109%      -0.1        0.19 ± 45%      -0.1        0.14 ± 40%  perf-profile.children.cycles-pp.prep_new_page
      0.32 ± 20%      -0.1        0.24 ± 15%      -0.0        0.31 ± 12%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.16 ± 16%      -0.1        0.09 ± 29%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.__remove_mapping
      0.17 ± 16%      -0.1        0.09 ± 25%      -0.1        0.10 ± 34%  perf-profile.children.cycles-pp.remove_mapping
      0.15 ± 60%      -0.1        0.08 ± 47%      +0.0        0.16 ± 28%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.13 ± 15%      -0.1        0.05 ± 46%      -0.1        0.06 ± 68%  perf-profile.children.cycles-pp.__delete_from_page_cache
      0.13 ± 30%      -0.1        0.06 ± 78%      -0.0        0.12 ± 36%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.20 ± 30%      -0.1        0.13 ± 32%      -0.0        0.19 ± 32%  perf-profile.children.cycles-pp.ata_scsi_queuecmd
      0.15 ± 29%      -0.1        0.08 ± 74%      -0.1        0.09 ± 47%  perf-profile.children.cycles-pp.mntput_no_expire
      0.16 ± 19%      -0.1        0.08 ± 81%      -0.0        0.14 ± 39%  perf-profile.children.cycles-pp.__ata_scsi_queuecmd
      0.32 ± 10%      -0.1        0.25 ± 30%      -0.0        0.28 ± 13%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.11 ± 50%      -0.1        0.04 ± 77%      -0.1        0.06 ± 44%  perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
      0.50 ± 15%      -0.1        0.43 ±  8%      -0.0        0.45 ± 10%  perf-profile.children.cycles-pp._copy_to_user
      0.29 ± 30%      -0.1        0.22 ± 36%      +0.0        0.33 ± 44%  perf-profile.children.cycles-pp.verify_dirent_name
      0.30 ± 30%      -0.1        0.23 ± 39%      -0.1        0.23 ± 24%  perf-profile.children.cycles-pp.io_schedule_timeout
      0.80 ± 20%      -0.1        0.74 ± 46%      -0.0        0.78 ± 14%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      0.37 ± 12%      -0.1        0.30 ± 15%      -0.0        0.35 ± 21%  perf-profile.children.cycles-pp.__x64_sys_utime
      0.62 ±  9%      -0.1        0.56 ± 20%      -0.0        0.60 ± 15%  perf-profile.children.cycles-pp.security_task_kill
      0.12 ± 27%      -0.1        0.06 ± 73%      -0.0        0.10 ± 28%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
      0.19 ± 43%      -0.1        0.13 ± 50%      -0.0        0.19 ± 28%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.13 ± 20%      -0.1        0.06 ± 72%      -0.0        0.10 ± 46%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.32 ± 18%      -0.1        0.25 ± 38%      -0.1        0.25 ± 24%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.44 ± 14%      -0.1        0.38 ± 13%      -0.0        0.41 ± 16%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.32 ± 18%      -0.1        0.26 ± 38%      -0.1        0.25 ± 24%  perf-profile.children.cycles-pp.__libc_write
      0.10 ± 42%      -0.1        0.03 ±103%      -0.1        0.04 ± 86%  perf-profile.children.cycles-pp.fixup_exception
      0.17 ± 12%      -0.1        0.11 ± 57%      +0.0        0.17 ± 18%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.24 ± 25%      -0.1        0.18 ± 12%      -0.0        0.22 ± 22%  perf-profile.children.cycles-pp.set_next_entity
      1.60 ± 23%      -0.1        1.54 ± 29%      -0.2        1.40 ±  7%  perf-profile.children.cycles-pp.f2fs_add_inline_entry
      0.98 ± 13%      -0.1        0.92 ± 12%      -0.0        0.95 ±  9%  perf-profile.children.cycles-pp.generic_permission
      1.10 ± 10%      -0.1        1.04 ± 22%      +0.4        1.49 ± 36%  perf-profile.children.cycles-pp.__pagevec_release
      0.13 ± 30%      -0.1        0.07 ±100%      -0.0        0.08 ± 39%  perf-profile.children.cycles-pp.radix_tree_insert
      0.84 ± 11%      -0.1        0.78 ±  6%      +0.0        0.87 ±  9%  perf-profile.children.cycles-pp.group_send_sig_info
      0.18 ± 40%      -0.1        0.13 ± 59%      +0.0        0.21 ± 23%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.10 ± 38%      -0.1        0.04 ±109%      -0.0        0.08 ± 33%  perf-profile.children.cycles-pp.folio_account_cleaned
      0.27 ± 33%      -0.1        0.21 ± 22%      +0.1        0.34 ± 42%  perf-profile.children.cycles-pp.lru_add_drain
      1.46 ±  9%      -0.1        1.40 ±  7%      -0.0        1.43 ±  4%  perf-profile.children.cycles-pp.kill_something_info
      0.25 ± 44%      -0.1        0.19 ± 46%      -0.1        0.19 ± 29%  perf-profile.children.cycles-pp.security_inode_permission
      0.31 ± 17%      -0.1        0.25 ± 11%      -0.0        0.27 ± 16%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      1.06 ± 21%      -0.1        1.00 ± 14%      +0.1        1.19 ± 23%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.25 ± 27%      -0.1        0.20 ± 50%      -0.0        0.22 ± 20%  perf-profile.children.cycles-pp.stack_access_ok
      0.08 ± 53%      -0.1        0.03 ±100%      -0.0        0.04 ± 84%  perf-profile.children.cycles-pp.__put_user_nocheck_8
      0.17 ± 29%      -0.1        0.12 ± 53%      -0.0        0.16 ± 40%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.13 ± 48%      -0.1        0.08 ± 74%      +0.0        0.13 ± 38%  perf-profile.children.cycles-pp.f2fs_invalidate_blocks
      0.23 ± 17%      -0.1        0.18 ± 20%      +0.0        0.24 ± 25%  perf-profile.children.cycles-pp.alloc_fd
      0.40 ± 12%      -0.1        0.35 ±  8%      -0.0        0.38 ± 23%  perf-profile.children.cycles-pp.utime
      0.07 ± 46%      -0.1        0.02 ±141%      -0.0        0.06 ± 78%  perf-profile.children.cycles-pp.f2fs_delete_inline_entry
      0.16 ± 19%      -0.1        0.11 ± 52%      +0.0        0.18 ± 20%  perf-profile.children.cycles-pp.__slab_free
      0.10 ± 67%      -0.1        0.05 ± 76%      -0.0        0.07 ± 60%  perf-profile.children.cycles-pp.security_file_free
      0.10 ± 60%      -0.1        0.05 ±110%      -0.0        0.07 ± 61%  perf-profile.children.cycles-pp.f2fs_update_extent_tree_range
      0.16 ± 54%      -0.1        0.11 ± 52%      -0.0        0.14 ± 30%  perf-profile.children.cycles-pp.d_alloc
      0.19 ± 23%      -0.1        0.14 ± 35%      +0.0        0.21 ± 30%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.24 ± 26%      -0.1        0.19 ± 39%      +0.0        0.29 ± 54%  perf-profile.children.cycles-pp.memchr
      1.14 ± 10%      -0.1        1.09 ± 15%      -0.0        1.13 ±  5%  perf-profile.children.cycles-pp.do_open
      2.00 ± 15%      -0.1        1.95 ± 10%      +0.1        2.11 ± 10%  perf-profile.children.cycles-pp.blk_complete_reqs
      0.06 ± 52%      -0.1        0.01 ±223%      -0.0        0.03 ±105%  perf-profile.children.cycles-pp.strcasecmp@plt
      0.36 ± 27%      -0.0        0.30 ± 18%      -0.0        0.33 ±  6%  perf-profile.children.cycles-pp.terminate_walk
      0.29 ± 46%      -0.0        0.24 ± 19%      +0.1        0.36 ± 26%  perf-profile.children.cycles-pp.update_load_avg
      5.60 ±  2%      -0.0        5.55 ±  9%      -0.0        5.59 ±  8%  perf-profile.children.cycles-pp.link_path_walk
      1.61 ± 23%      -0.0        1.56 ± 28%      -0.2        1.42 ±  8%  perf-profile.children.cycles-pp.f2fs_add_dentry
      0.07 ± 50%      -0.0        0.02 ±144%      -0.1        0.02 ±154%  perf-profile.children.cycles-pp.bsearch
      0.08 ± 54%      -0.0        0.03 ±102%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.search_exception_tables
      0.06 ± 55%      -0.0        0.02 ±223%      +0.0        0.09 ± 46%  perf-profile.children.cycles-pp.fput_many
      0.34 ± 18%      -0.0        0.29 ± 14%      -0.0        0.33 ± 25%  perf-profile.children.cycles-pp.do_utimes
      1.36 ± 16%      -0.0        1.32 ± 13%      -0.0        1.31 ±  9%  perf-profile.children.cycles-pp.__entry_text_start
      1.30 ±  5%      -0.0        1.26 ± 16%      +0.1        1.40 ± 37%  perf-profile.children.cycles-pp.task_work_run
      0.21 ± 26%      -0.0        0.16 ± 21%      -0.0        0.20 ± 15%  perf-profile.children.cycles-pp.f2fs_hash_filename
      0.21 ± 33%      -0.0        0.16 ± 37%      -0.0        0.21 ± 22%  perf-profile.children.cycles-pp.f2fs_setup_filename
      0.47 ± 21%      -0.0        0.42 ± 22%      +0.1        0.53 ± 17%  perf-profile.children.cycles-pp.touch_atime
      0.05 ± 71%      -0.0        0.00            -0.0        0.02 ±154%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
      0.09 ± 59%      -0.0        0.04 ±103%      -0.0        0.06 ± 62%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.06 ± 72%      -0.0        0.01 ±223%      -0.0        0.05 ± 77%  perf-profile.children.cycles-pp.__native_queued_spin_unlock
      0.09 ± 63%      -0.0        0.05 ± 70%      -0.0        0.09 ± 33%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      1.32 ± 44%      -0.0        1.28 ± 26%      -0.4        0.90 ± 19%  perf-profile.children.cycles-pp.ksys_read
      0.23 ± 22%      -0.0        0.18 ± 46%      -0.1        0.17 ± 24%  perf-profile.children.cycles-pp.set_root
      0.07 ± 55%      -0.0        0.03 ±102%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.search_extable
      0.15 ± 56%      -0.0        0.10 ± 56%      -0.0        0.13 ± 28%  perf-profile.children.cycles-pp.__d_alloc
      0.12 ± 43%      -0.0        0.08 ± 31%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.f2fs_update_parent_metadata
      0.18 ± 25%      -0.0        0.14 ± 20%      -0.0        0.16 ± 43%  perf-profile.children.cycles-pp.update_rq_clock
      0.94 ±  8%      -0.0        0.90 ±  5%      +0.0        0.98 ±  9%  perf-profile.children.cycles-pp.kill_pid_info
      0.06 ± 81%      -0.0        0.02 ±141%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.sock_sendmsg
      0.05 ± 54%      -0.0        0.01 ±223%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.blk_mq_attempt_bio_merge
      0.10 ± 35%      -0.0        0.06 ± 54%      -0.0        0.08 ± 83%  perf-profile.children.cycles-pp.shmem_write_begin
      0.18 ± 27%      -0.0        0.13 ± 35%      +0.0        0.20 ± 29%  perf-profile.children.cycles-pp.native_sched_clock
      0.30 ± 32%      -0.0        0.26 ± 31%      +0.2        0.48 ± 87%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      1.71 ± 21%      -0.0        1.67 ± 28%      -0.2        1.53 ±  6%  perf-profile.children.cycles-pp.f2fs_do_add_link
      1.61 ± 13%      -0.0        1.57 ± 23%      +0.1        1.71 ± 11%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      0.13 ± 20%      -0.0        0.09 ± 29%      -0.1        0.08 ± 43%  perf-profile.children.cycles-pp.__alloc_nat_entry
      0.06 ± 52%      -0.0        0.02 ±144%      +0.0        0.07 ± 47%  perf-profile.children.cycles-pp.__mutex_lock
      0.10 ± 35%      -0.0        0.06 ± 53%      -0.0        0.07 ± 86%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.05 ± 56%      -0.0        0.01 ±223%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.blk_attempt_plug_merge
      0.05 ± 73%      -0.0        0.01 ±223%      -0.0        0.02 ±124%  perf-profile.children.cycles-pp.blk_mq_complete_request
      0.05 ± 83%      -0.0        0.01 ±223%      -0.0        0.04 ± 67%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.04 ± 71%      -0.0        0.00            -0.0        0.04 ± 82%  perf-profile.children.cycles-pp.__is_cp_guaranteed
      0.39 ± 19%      -0.0        0.35 ± 18%      -0.1        0.33 ± 22%  perf-profile.children.cycles-pp.__statfs
      1.91 ± 16%      -0.0        1.87 ± 10%      +0.1        2.02 ± 10%  perf-profile.children.cycles-pp.scsi_io_completion
      0.06 ± 52%      -0.0        0.02 ±142%      -0.0        0.06 ± 74%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.10 ±  5%      -0.0        0.06 ± 75%      -0.1        0.05 ± 69%  perf-profile.children.cycles-pp.__kmalloc_node
      0.18 ± 29%      -0.0        0.14 ± 37%      -0.0        0.15 ± 62%  perf-profile.children.cycles-pp.__bio_alloc
      0.04 ± 72%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.expand_files
      0.04 ±143%      -0.0        0.00            -0.0        0.01 ±201%  perf-profile.children.cycles-pp.blk_mq_rq_ctx_init
      1.00 ± 12%      -0.0        0.96 ± 18%      -0.1        0.92 ± 17%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.06 ± 58%      -0.0        0.03 ±100%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp.do_set_pte
      0.89 ± 19%      -0.0        0.85 ± 22%      +0.1        0.96 ± 15%  perf-profile.children.cycles-pp.swake_up_locked
      0.16 ± 29%      -0.0        0.12 ± 44%      -0.0        0.12 ± 20%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.11 ± 41%      -0.0        0.08 ± 52%      -0.0        0.09 ± 38%  perf-profile.children.cycles-pp.__ctype_b_loc@plt
      0.05 ± 77%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.iostat_alloc_and_bind_ctx
      0.09 ± 45%      -0.0        0.05 ±116%      -0.0        0.08 ± 49%  perf-profile.children.cycles-pp.clear_node_page_dirty
      0.06 ± 76%      -0.0        0.02 ±144%      -0.0        0.03 ±125%  perf-profile.children.cycles-pp.dd_insert_requests
      0.06 ± 51%      -0.0        0.03 ±144%      -0.0        0.05 ±104%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.05 ± 51%      -0.0        0.02 ±141%      -0.0        0.04 ±116%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.06 ± 58%      -0.0        0.03 ±100%      -0.0        0.06 ± 60%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.44 ± 18%      -0.0        0.41 ± 20%      -0.0        0.40 ± 19%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.32 ± 21%      -0.0        0.29 ± 33%      -0.1        0.25 ± 22%  perf-profile.children.cycles-pp.security_inode_getattr
      0.12 ± 59%      -0.0        0.08 ± 61%      -0.0        0.08 ± 42%  perf-profile.children.cycles-pp.f2fs_destroy_extent_tree
      0.11 ± 27%      -0.0        0.07 ± 75%      -0.0        0.06 ± 56%  perf-profile.children.cycles-pp.f2fs_merge_page_bio
      0.04 ± 80%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__init_nat_entry
      0.16 ± 29%      -0.0        0.12 ± 28%      -0.0        0.16 ± 32%  perf-profile.children.cycles-pp.strchr@plt
      1.90 ± 15%      -0.0        1.86 ± 10%      +0.1        2.02 ± 11%  perf-profile.children.cycles-pp.scsi_end_request
      0.05 ± 77%      -0.0        0.02 ±223%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.file_ra_state_init
      0.09 ± 52%      -0.0        0.06 ± 80%      +0.0        0.09 ± 46%  perf-profile.children.cycles-pp.f2fs_sync_inode_meta
      0.03 ±150%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.dquot_file_open
      0.04 ±107%      -0.0        0.01 ±223%      -0.0        0.03 ±134%  perf-profile.children.cycles-pp.__blk_mq_get_driver_tag
      0.52 ± 15%      -0.0        0.48 ± 18%      -0.1        0.46 ± 17%  perf-profile.children.cycles-pp.filemap_get_pages
      0.05 ± 90%      -0.0        0.02 ±223%      -0.0        0.02 ±122%  perf-profile.children.cycles-pp.scsi_init_command
      0.48 ± 12%      -0.0        0.45 ± 14%      +0.0        0.49 ± 12%  perf-profile.children.cycles-pp.security_file_alloc
      0.42 ± 10%      -0.0        0.39 ± 25%      +0.0        0.43 ± 41%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.15 ± 18%      -0.0        0.12 ± 38%      +0.0        0.16 ± 26%  perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.04 ±103%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.page_add_file_rmap
      0.08 ± 16%      -0.0        0.05 ±102%      -0.0        0.05 ± 58%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.03 ±102%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.lru_deactivate_file_fn
      0.09 ± 70%      -0.0        0.06 ± 73%      -0.0        0.09 ± 32%  perf-profile.children.cycles-pp.error_entry
      0.04 ± 72%      -0.0        0.01 ±223%      -0.0        0.04 ±104%  perf-profile.children.cycles-pp.locate_dirty_segment
      0.14 ± 19%      -0.0        0.11 ± 35%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.make_kgid
      0.09 ± 20%      -0.0        0.06 ± 80%      -0.0        0.07 ± 41%  perf-profile.children.cycles-pp.get_task_policy
      0.04 ±100%      -0.0        0.01 ±223%      -0.0        0.02 ±126%  perf-profile.children.cycles-pp.PyUnicode_New
      0.07 ± 49%      -0.0        0.04 ±104%      -0.0        0.07 ± 41%  perf-profile.children.cycles-pp.uncharge_batch
      0.06 ± 50%      -0.0        0.03 ±146%      +0.0        0.06 ± 53%  perf-profile.children.cycles-pp.writeback_single_inode
      0.06 ±123%      -0.0        0.03 ±155%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.06 ±103%      -0.0        0.02 ±145%      -0.0        0.04 ± 66%  perf-profile.children.cycles-pp.d_instantiate_new
      0.04 ±102%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.free_buffer_head
      0.03 ±101%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.find_vpid
      0.03 ±101%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.ksoftirqd_running
      0.03 ±152%      -0.0        0.00            -0.0        0.01 ±200%  perf-profile.children.cycles-pp.folio_memcg_unlock
      0.09 ± 48%      -0.0        0.06 ± 52%      -0.0        0.08 ± 40%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.04 ±167%      -0.0        0.01 ±223%      +0.0        0.04 ± 93%  perf-profile.children.cycles-pp.folio_unlock
      0.07 ± 50%      -0.0        0.04 ±141%      +0.0        0.07 ± 39%  perf-profile.children.cycles-pp.sync_inode_metadata
      0.24 ± 27%      -0.0        0.21 ± 18%      +0.0        0.25 ± 23%  perf-profile.children.cycles-pp.f2fs_mark_inode_dirty_sync
      0.24 ± 19%      -0.0        0.21 ± 39%      +0.0        0.25 ± 30%  perf-profile.children.cycles-pp.malloc
      0.07 ± 69%      -0.0        0.04 ±107%      +0.0        0.12 ± 33%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.08 ± 65%      -0.0        0.05 ±102%      -0.0        0.06 ± 73%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.14 ± 13%      -0.0        0.12 ± 30%      -0.0        0.11 ± 47%  perf-profile.children.cycles-pp.__switch_to_asm
      0.22 ± 18%      -0.0        0.20 ± 40%      -0.1        0.16 ± 30%  perf-profile.children.cycles-pp.common_perm_cond
      0.07 ± 76%      -0.0        0.04 ± 73%      -0.0        0.05 ± 89%  perf-profile.children.cycles-pp.strlen@plt
      0.04 ±100%      -0.0        0.01 ±223%      +0.0        0.04 ±111%  perf-profile.children.cycles-pp.f2fs_update_iostat
      0.04 ±107%      -0.0        0.01 ±223%      +0.0        0.05 ± 73%  perf-profile.children.cycles-pp.task_work_add
      0.03 ±102%      -0.0        0.00            -0.0        0.01 ±202%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.03 ±102%      -0.0        0.00            +0.0        0.03 ±105%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.15 ± 19%      -0.0        0.12 ± 49%      +0.0        0.19 ± 36%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.07 ± 53%      -0.0        0.04 ±109%      -0.0        0.04 ± 84%  perf-profile.children.cycles-pp.apparmor_file_open
      0.12 ± 62%      -0.0        0.09 ± 64%      -0.0        0.12 ± 31%  perf-profile.children.cycles-pp.lockref_put_return
      0.36 ± 31%      -0.0        0.34 ± 23%      +0.1        0.44 ± 35%  perf-profile.children.cycles-pp.atime_needs_update
      0.04 ±104%      -0.0        0.01 ±223%      +0.0        0.05 ± 54%  perf-profile.children.cycles-pp.sbitmap_get
      0.03 ±147%      -0.0        0.00            -0.0        0.02 ±123%  perf-profile.children.cycles-pp.__check_heap_object
      0.06 ± 78%      -0.0        0.03 ±106%      -0.0        0.04 ± 86%  perf-profile.children.cycles-pp.ata_scsi_qc_complete
      0.14 ± 29%      -0.0        0.11 ± 33%      -0.1        0.08 ± 53%  perf-profile.children.cycles-pp.f2fs_inplace_write_data
      0.10 ± 30%      -0.0        0.07 ± 49%      -0.0        0.08 ± 62%  perf-profile.children.cycles-pp.notify_change
      0.14 ± 42%      -0.0        0.12 ± 54%      +0.1        0.21 ± 28%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.14 ± 37%      -0.0        0.12 ± 24%      -0.0        0.12 ± 48%  perf-profile.children.cycles-pp.f2fs_getxattr
      0.09 ± 28%      -0.0        0.06 ± 55%      -0.0        0.07 ± 42%  perf-profile.children.cycles-pp.__lookup_mnt
      0.14 ± 20%      -0.0        0.11 ±  9%      +0.0        0.14 ± 29%  perf-profile.children.cycles-pp.path_put
      0.06 ± 76%      -0.0        0.04 ±105%      +0.0        0.07 ± 71%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.12 ± 11%      -0.0        0.10 ± 45%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.inode_to_bdi
      0.02 ±152%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp._IO_file_write
      0.02 ±152%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.set_next_buddy
      0.04 ± 78%      -0.0        0.02 ±144%      -0.0        0.04 ±115%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.02 ±152%      -0.0        0.00            +0.0        0.03 ±129%  perf-profile.children.cycles-pp.__mnt_want_write
      0.04 ± 80%      -0.0        0.02 ±142%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.update_min_vruntime
      0.04 ±106%      -0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.f2fs_file_flush
      0.04 ±118%      -0.0        0.02 ±223%      -0.0        0.04 ± 87%  perf-profile.children.cycles-pp.rq_qos_wait
      0.03 ±103%      -0.0        0.01 ±223%      +0.0        0.06 ± 64%  perf-profile.children.cycles-pp.f2fs_inode_synced
      0.04 ± 80%      -0.0        0.02 ±142%      +0.0        0.07 ± 82%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.07 ± 72%      -0.0        0.04 ±102%      +0.0        0.09 ± 29%  perf-profile.children.cycles-pp.__fdget_pos
      0.02 ±145%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_drop_nlink
      0.18 ± 32%      -0.0        0.15 ± 26%      +0.0        0.19 ± 43%  perf-profile.children.cycles-pp.call_rcu
      0.67 ± 16%      -0.0        0.64 ± 11%      +0.0        0.69 ± 11%  perf-profile.children.cycles-pp.rcu_do_batch
      9.00 ±  4%      -0.0        8.98 ±  7%      -0.1        8.92 ±  4%  perf-profile.children.cycles-pp.path_openat
      0.16 ± 20%      -0.0        0.13 ± 20%      -0.0        0.13 ± 26%  perf-profile.children.cycles-pp.from_kuid_munged
      0.27 ± 19%      -0.0        0.25 ± 28%      +0.1        0.32 ± 51%  perf-profile.children.cycles-pp.exit_mmap
      0.27 ± 19%      -0.0        0.25 ± 28%      +0.1        0.33 ± 51%  perf-profile.children.cycles-pp.mmput
      0.08 ± 48%      -0.0        0.05 ± 46%      +0.0        0.10 ± 58%  perf-profile.children.cycles-pp.__switch_to
      0.05 ± 91%      -0.0        0.03 ±102%      +0.0        0.08 ± 58%  perf-profile.children.cycles-pp.core_kernel_text
      0.02 ±143%      -0.0        0.00            -0.0        0.01 ±203%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      0.06 ± 76%      -0.0        0.03 ±102%      -0.1        0.01 ±299%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.22 ± 17%      -0.0        0.20 ± 33%      -0.1        0.16 ± 41%  perf-profile.children.cycles-pp.dup_mm
      0.22 ± 29%      -0.0        0.19 ± 27%      -0.0        0.18 ± 30%  perf-profile.children.cycles-pp.__ctype_b_loc
      0.16 ± 29%      -0.0        0.14 ± 36%      -0.0        0.15 ± 36%  perf-profile.children.cycles-pp.workingset_activation
      0.20 ± 42%      -0.0        0.18 ± 26%      +0.0        0.24 ± 17%  perf-profile.children.cycles-pp.__fget_light
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.raise_softirq
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.___sys_sendmsg
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.____sys_sendmsg
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__sys_sendmsg
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.unix_stream_sendmsg
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.f2fs_destroy_extent_node
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.sched_slice
      0.02 ±146%      -0.0        0.00            -0.0        0.01 ±201%  perf-profile.children.cycles-pp.create_elf_tables
      0.03 ±105%      -0.0        0.01 ±223%      -0.0        0.03 ±131%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.09 ± 58%      -0.0        0.07 ± 83%      +0.0        0.09 ± 43%  perf-profile.children.cycles-pp.putname
      0.02 ±142%      -0.0        0.00            +0.0        0.02 ±124%  perf-profile.children.cycles-pp.generic_update_time
      0.15 ± 49%      -0.0        0.12 ± 24%      +0.0        0.16 ± 16%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.08 ± 87%      -0.0        0.06 ± 76%      +0.0        0.12 ± 32%  perf-profile.children.cycles-pp.f2fs_file_open
      1.16 ± 20%      -0.0        1.14 ± 15%      +0.1        1.31 ± 22%  perf-profile.children.cycles-pp.fault_in_readable
      0.10 ± 49%      -0.0        0.08 ± 50%      -0.0        0.07 ± 54%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.f2fs_get_node_page
      0.02 ±144%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.sched_move_task
      0.02 ±141%      -0.0        0.00            -0.0        0.01 ±200%  perf-profile.children.cycles-pp.rcu_gp_init
      0.04 ±104%      -0.0        0.02 ±142%      +0.0        0.05 ± 87%  perf-profile.children.cycles-pp.__d_lookup
      0.08 ± 52%      -0.0        0.06 ±104%      +0.0        0.08 ± 39%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.18 ± 24%      -0.0        0.16 ± 18%      +0.0        0.22 ± 26%  perf-profile.children.cycles-pp.f2fs_update_inode
      0.04 ±112%      -0.0        0.03 ±155%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.list_lru_add
      0.04 ±110%      -0.0        0.02 ±144%      +0.0        0.04 ± 85%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.04 ±110%      -0.0        0.02 ±144%      +0.0        0.04 ± 85%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.04 ± 78%      -0.0        0.03 ±100%      +0.0        0.07 ± 69%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.03 ±105%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.read_inline_xattr
      0.03 ±144%      -0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.get_stack_info
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.f2fs_room_for_filename
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.igb_rd32
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.igb_update_stats
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±201%  perf-profile.children.cycles-pp.__lookup_hash
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±201%  perf-profile.children.cycles-pp.lookup_dcache
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±200%  perf-profile.children.cycles-pp.anon_vma_fork
      0.02 ±142%      -0.0        0.00            -0.0        0.02 ±155%  perf-profile.children.cycles-pp.reweight_entity
      0.03 ±101%      -0.0        0.01 ±223%      +0.0        0.04 ± 68%  perf-profile.children.cycles-pp.pick_next_entity
      0.04 ±114%      -0.0        0.02 ±149%      +0.0        0.04 ± 85%  perf-profile.children.cycles-pp.wbt_wait
      0.13 ± 17%      -0.0        0.11 ± 30%      +0.0        0.13 ± 61%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.24 ± 25%      -0.0        0.22 ± 31%      -0.0        0.24 ± 17%  perf-profile.children.cycles-pp.__f2fs_setup_filename
      0.16 ± 41%      -0.0        0.14 ± 25%      -0.1        0.10 ± 39%  perf-profile.children.cycles-pp.strtoll
      0.05 ±142%      -0.0        0.03 ±144%      -0.0        0.03 ±106%  perf-profile.children.cycles-pp.closedir
      0.04 ±109%      -0.0        0.02 ±223%      +0.0        0.04 ±107%  perf-profile.children.cycles-pp.f2fs_truncate_inode_blocks
      0.02 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.02 ±141%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__maps__insert
      0.02 ±141%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.04 ±142%      -0.0        0.02 ±144%      -0.0        0.03 ±125%  perf-profile.children.cycles-pp.__destroy_inode
      0.02 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__insert_extent_tree
      0.02 ±141%      -0.0        0.00            -0.0        0.01 ±201%  perf-profile.children.cycles-pp.ata_scsi_rw_xlat
      0.02 ±141%      -0.0        0.00            +0.0        0.02 ±154%  perf-profile.children.cycles-pp.__dma_map_sg_attrs
      0.02 ±141%      -0.0        0.00            +0.0        0.02 ±154%  perf-profile.children.cycles-pp.dma_map_sg_attrs
      0.02 ±223%      -0.0        0.00            +0.0        0.03 ±133%  perf-profile.children.cycles-pp.kick_process
      0.18 ± 15%      -0.0        0.16 ± 38%      -0.0        0.15 ± 27%  perf-profile.children.cycles-pp.may_open
      0.05 ± 79%      -0.0        0.04 ±115%      -0.0        0.03 ±128%  perf-profile.children.cycles-pp.blk_mq_start_request
      0.14 ± 31%      -0.0        0.13 ± 36%      -0.0        0.13 ± 57%  perf-profile.children.cycles-pp.mempool_alloc
      0.08 ± 54%      -0.0        0.06 ± 51%      -0.0        0.07 ± 60%  perf-profile.children.cycles-pp.mutex_lock
      0.05 ± 87%      -0.0        0.04 ±101%      +0.0        0.06 ± 53%  perf-profile.children.cycles-pp.f2fs_alloc_nid_done
      0.28 ± 24%      -0.0        0.26 ± 24%      +0.1        0.33 ± 22%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.04 ± 82%      -0.0        0.02 ±152%      +0.0        0.06 ± 72%  perf-profile.children.cycles-pp.menu_select
      0.13 ± 24%      -0.0        0.11 ± 61%      +0.0        0.16 ±107%  perf-profile.children.cycles-pp.unmap_page_range
      0.21 ± 35%      -0.0        0.19 ± 33%      -0.0        0.18 ± 31%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      2.23 ± 17%      -0.0        2.22 ± 28%      +0.1        2.37 ± 20%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.95 ± 15%      -0.0        0.94 ± 24%      +0.3        1.30 ± 40%  perf-profile.children.cycles-pp.release_pages
      0.97 ± 13%      -0.0        0.96 ± 17%      -0.1        0.90 ± 16%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.74 ± 35%      -0.0        0.72 ± 11%      -0.0        0.70 ± 29%  perf-profile.children.cycles-pp.handle_mm_fault
      0.05 ± 76%      -0.0        0.04 ±115%      +0.0        0.06 ± 74%  perf-profile.children.cycles-pp.load_new_mm_cr3
      0.02 ±152%      -0.0        0.01 ±223%      +0.0        0.05 ± 69%  perf-profile.children.cycles-pp.insert_inode_locked
      0.04 ±141%      -0.0        0.02 ±144%      -0.0        0.02 ±154%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      0.03 ±147%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__get_free_pages
      0.03 ±100%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.cmp_ex_search
      0.11 ± 55%      -0.0        0.09 ± 67%      -0.0        0.08 ± 40%  perf-profile.children.cycles-pp.common_perm
      0.05 ±109%      -0.0        0.03 ±102%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.f2fs_invalidate_page
      0.07 ± 57%      -0.0        0.05 ± 76%      -0.0        0.06 ± 61%  perf-profile.children.cycles-pp.pagevec_add_and_need_flush
      0.04 ± 72%      -0.0        0.03 ±100%      +0.0        0.06 ± 40%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.37 ± 19%      -0.0        0.36 ± 11%      -0.0        0.34 ± 17%  perf-profile.children.cycles-pp.f2fs_getattr
      1.26 ±  8%      -0.0        1.25 ± 15%      +0.0        1.31 ± 12%  perf-profile.children.cycles-pp.filldir64
      0.39 ± 18%      -0.0        0.38 ± 15%      +0.0        0.42 ± 24%  perf-profile.children.cycles-pp.task_tick_fair
      0.04 ±107%      -0.0        0.02 ±141%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.04 ± 73%      -0.0        0.03 ±146%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.PyObject_GetAttr
      0.12 ± 13%      -0.0        0.11 ± 29%      -0.0        0.10 ± 48%  perf-profile.children.cycles-pp.vfs_utimes
      0.15 ± 34%      -0.0        0.13 ± 59%      -0.0        0.13 ± 45%  perf-profile.children.cycles-pp.blk_mq_requeue_work
      0.22 ± 23%      -0.0        0.20 ± 40%      -0.0        0.21 ± 13%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.22 ± 23%      -0.0        0.20 ± 40%      -0.0        0.21 ± 13%  perf-profile.children.cycles-pp.do_group_exit
      0.22 ± 23%      -0.0        0.20 ± 40%      -0.0        0.21 ± 13%  perf-profile.children.cycles-pp.do_exit
      0.04 ± 80%      -0.0        0.03 ±146%      +0.0        0.05 ± 86%  perf-profile.children.cycles-pp.mnt_want_write
      0.04 ±143%      -0.0        0.03 ±105%      +0.0        0.08 ± 31%  perf-profile.children.cycles-pp.fscrypt_file_open
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.closedir@plt
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.do_wp_page
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.semop
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.netlink_sendmsg
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.file_free_rcu
      0.04 ± 72%      -0.0        0.02 ±141%      -0.0        0.04 ± 84%  perf-profile.children.cycles-pp.filename_create
      0.54 ± 25%      -0.0        0.53 ±  7%      -0.0        0.50 ± 19%  perf-profile.children.cycles-pp.f2fs_truncate_data_blocks_range
      0.84 ±  8%      -0.0        0.83 ± 11%      -0.0        0.83 ± 13%  perf-profile.children.cycles-pp.map_id_range_down
      0.26 ± 31%      -0.0        0.24 ± 18%      -0.0        0.21 ± 17%  perf-profile.children.cycles-pp.generic_fillattr
      0.04 ±149%      -0.0        0.02 ±145%      -0.0        0.03 ±133%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.08 ± 19%      -0.0        0.06 ± 77%      -0.0        0.07 ± 30%  perf-profile.children.cycles-pp.strlen
      0.04 ±110%      -0.0        0.03 ±103%      -0.0        0.04 ± 84%  perf-profile.children.cycles-pp.uncharge_folio
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.netlink_unicast
      0.02 ±143%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__acct_update_integrals
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.d_flags_for_inode
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.irqentry_exit
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__mbrtowc
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__inode_attach_wb
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.blk_start_plug
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.generic_file_open
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.inode_io_list_del
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__rq_qos_track
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.find_get_entries
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.inode_io_list_move_locked
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.internal_add_timer
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.mm_init
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.pgd_alloc
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.sock_def_readable
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__sysconf
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.mark_page_accessed
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.maps__insert
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.del_timer_sync
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.try_to_del_timer_sync
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±203%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.strnlen_user
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.se_is_idle
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.ktime_get_mono_fast_ns
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.place_entity
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.ep_poll_callback
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.__sys_sendto
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.__x64_sys_sendto
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±200%  perf-profile.children.cycles-pp.__pmd_alloc
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±203%  perf-profile.children.cycles-pp.__libc_pread64
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.clear_buddies
      0.01 ±223%      -0.0        0.00            +0.1        0.08 ±254%  perf-profile.children.cycles-pp.wake_up_new_task
      0.05 ± 56%      -0.0        0.04 ±111%      -0.0        0.04 ± 85%  perf-profile.children.cycles-pp.aa_file_perm
      0.04 ±107%      -0.0        0.03 ±146%      -0.0        0.04 ±104%  perf-profile.children.cycles-pp.devkmsg_read
      0.04 ±111%      -0.0        0.03 ±101%      +0.0        0.08 ± 57%  perf-profile.children.cycles-pp.ata_qc_issue
      0.14 ± 35%      -0.0        0.13 ± 28%      -0.0        0.12 ± 45%  perf-profile.children.cycles-pp.__f2fs_get_acl
      0.53 ± 21%      -0.0        0.52 ± 13%      -0.0        0.53 ± 19%  perf-profile.children.cycles-pp.update_process_times
      2.10 ±  4%      -0.0        2.09 ± 15%      +0.2        2.30 ± 21%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.29 ± 13%      -0.0        0.28 ± 23%      -0.0        0.28 ± 16%  perf-profile.children.cycles-pp.f2fs_find_entry
      0.12 ± 30%      -0.0        0.11 ± 22%      +0.0        0.13 ± 41%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.13 ± 17%      -0.0        0.12 ± 19%      +0.1        0.20 ± 35%  perf-profile.children.cycles-pp.f2fs_get_node_info
      0.04 ±107%      -0.0        0.03 ±143%      -0.0        0.03 ±106%  perf-profile.children.cycles-pp.perf_tp_event_match
      0.04 ±112%      -0.0        0.04 ±115%      -0.0        0.04 ±101%  perf-profile.children.cycles-pp.d_lru_add
      0.07 ± 70%      -0.0        0.06 ± 81%      +0.0        0.07 ± 57%  perf-profile.children.cycles-pp.aa_get_task_label
      0.03 ±155%      -0.0        0.02 ±141%      +0.0        0.04 ± 85%  perf-profile.children.cycles-pp.mprotect_fixup
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__free_extent_tree
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_openat
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.ata_qc_new_init
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__msecs_to_jiffies
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.get_stack_info_noinstr
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.raw_notifier_call_chain
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.PyBytes_FromStringAndSize
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.PyUnicode_InternInPlace
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__alloc_skb
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.cursor_timer_handler
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.memcg_alloc_page_obj_cgroups
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.seq_puts
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__libc_sendmsg
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.note_gp_changes
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.do_semtimedop
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.epoll_wait
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.security_path_mknod
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.anon_vma_clone
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.generic_write_checks
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.error_return
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±209%  perf-profile.children.cycles-pp.put_cpu_partial
      0.02 ±144%      -0.0        0.01 ±223%      +0.0        0.03 ±127%  perf-profile.children.cycles-pp.unit_file_find_dropin_paths
      0.02 ±144%      -0.0        0.01 ±223%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.congestion_wait
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±126%  perf-profile.children.cycles-pp.__vma_adjust
      0.03 ±101%      -0.0        0.02 ±141%      +0.0        0.04 ± 93%  perf-profile.children.cycles-pp.update_sit_entry
      0.04 ±104%      -0.0        0.03 ±100%      +0.0        0.07 ± 55%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.10 ± 52%      -0.0        0.09 ± 51%      -0.0        0.08 ± 40%  perf-profile.children.cycles-pp.security_file_open
      0.46 ± 22%      -0.0        0.45 ± 17%      -0.0        0.42 ± 16%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.35 ± 22%      -0.0        0.34 ± 27%      -0.1        0.27 ± 22%  perf-profile.children.cycles-pp.vfs_getattr
      0.21 ± 36%      -0.0        0.20 ± 26%      +0.0        0.24 ± 23%  perf-profile.children.cycles-pp.current_time
      0.11 ± 25%      -0.0        0.10 ± 31%      -0.0        0.06 ± 43%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.03 ±223%      -0.0        0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.__d_instantiate
      0.03 ±141%      -0.0        0.02 ±143%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.03 ±100%      -0.0        0.02 ±223%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.add_free_nid
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.PyDict_SetItem
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__rq_qos_issue
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.bit_waitqueue
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.rw_verify_area
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__inode_wait_for_writeback
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__open64
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.common_perm_create
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.dcache_readdir
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.dquot_drop
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.elv_merge
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.kfree_skb
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__do_semtimedop
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__fsnotify_inode_delete
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.mem_cgroup_from_obj
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_poll
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.do_sys_poll
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__poll
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.rcu_segcblist_pend_cbs
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp._IO_getline
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.__move_free_nid
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.mnt_drop_write
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__srcu_read_unlock
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.ata_qc_complete
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.__sg_alloc_table
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.lock_timer_base
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.ktime_get_coarse_with_offset
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.mutex_unlock
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.memcg_check_events
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.update_io_ticks
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.locks_remove_file
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.idr_find
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.ip_sublist_rcv_finish
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.children.cycles-pp.ip_error
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.put_pid
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.lockref_get
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±203%  perf-profile.children.cycles-pp._PyEval_EvalCodeWithName
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.shmem_alloc_page
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±202%  perf-profile.children.cycles-pp.try_to_grab_pending
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.scsi_mq_uninit_cmd
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.dup_task_struct
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±165%  perf-profile.children.cycles-pp.igb_clean_rx_irq
      0.04 ±154%      -0.0        0.03 ±157%      -0.0        0.03 ±127%  perf-profile.children.cycles-pp.__dquot_initialize
      0.04 ± 79%      -0.0        0.04 ±107%      +0.0        0.05 ± 88%  perf-profile.children.cycles-pp.f2fs_setattr
      0.18 ± 16%      -0.0        0.18 ± 54%      +0.0        0.23 ± 23%  perf-profile.children.cycles-pp.f2fs_rename
      0.17 ± 20%      -0.0        0.16 ± 39%      -0.0        0.14 ± 49%  perf-profile.children.cycles-pp.try_charge_memcg
      0.18 ± 32%      -0.0        0.17 ± 53%      +0.2        0.34 ±139%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.04 ± 72%      -0.0        0.03 ±100%      +0.0        0.05 ± 92%  perf-profile.children.cycles-pp.update_cfs_group
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.d_path
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.prepend_path
      0.02 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.dget_parent
      0.02 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.remove_vma
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.02 ±155%  perf-profile.children.cycles-pp.sg_alloc_table_chained
      0.03 ±101%      -0.0        0.02 ±141%      +0.0        0.03 ±112%  perf-profile.children.cycles-pp.opendir
      0.03 ±100%      -0.0        0.03 ±100%      +0.0        0.05 ± 55%  perf-profile.children.cycles-pp.__alloc_pages_bulk
      0.03 ±100%      -0.0        0.03 ±100%      +0.0        0.06 ± 55%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.04 ±104%      -0.0        0.04 ±100%      -0.0        0.03 ±106%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.04 ±115%      -0.0        0.04 ±141%      -0.0        0.04 ± 84%  perf-profile.children.cycles-pp.f2fs_do_read_inline_data
      0.20 ± 16%      -0.0        0.19 ± 36%      -0.0        0.16 ± 43%  perf-profile.children.cycles-pp.dup_mmap
      0.28 ±  9%      -0.0        0.27 ± 25%      -0.0        0.25 ± 26%  perf-profile.children.cycles-pp.copy_process
      0.28 ± 26%      -0.0        0.28 ± 32%      -0.0        0.26 ± 29%  perf-profile.children.cycles-pp.user_statfs
      0.30 ±  5%      -0.0        0.30 ± 23%      +0.0        0.35 ± 58%  perf-profile.children.cycles-pp.kernel_clone
      0.53 ± 22%      -0.0        0.53 ± 14%      -0.0        0.53 ± 19%  perf-profile.children.cycles-pp.tick_sched_handle
      0.60 ±  8%      -0.0        0.59 ± 10%      +0.1        0.68 ± 13%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.21 ± 29%      -0.0        0.20 ± 21%      -0.0        0.18 ± 24%  perf-profile.children.cycles-pp.alloc_pages
      0.32 ± 23%      -0.0        0.31 ± 21%      -0.0        0.29 ± 24%  perf-profile.children.cycles-pp.__do_sys_statfs
      0.14 ± 28%      -0.0        0.14 ± 57%      -0.0        0.13 ± 55%  perf-profile.children.cycles-pp.blk_mq_run_hw_queues
      0.08 ± 57%      -0.0        0.08 ± 20%      -0.0        0.08 ± 64%  perf-profile.children.cycles-pp.PageHeadHuge
      0.11 ± 35%      -0.0        0.10 ± 48%      +0.0        0.12 ± 41%  perf-profile.children.cycles-pp.xas_find_conflict
      0.09 ± 53%      -0.0        0.09 ± 58%      +0.0        0.10 ± 36%  perf-profile.children.cycles-pp.f2fs_reserve_block
      0.31 ± 22%      -0.0        0.30 ± 22%      +0.0        0.35 ± 19%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.02 ±142%      -0.0        0.02 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__d_move
      0.02 ±142%      -0.0        0.02 ±223%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.d_move
      0.02 ±141%      -0.0        0.02 ±223%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.folio_mapped
      0.02 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.PyType_GenericAlloc
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.memmove@plt
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±203%  perf-profile.children.cycles-pp.delete_node
      0.04 ±142%      -0.0        0.03 ±102%      -0.0        0.03 ±125%  perf-profile.children.cycles-pp.destroy_inode
      0.04 ±147%      -0.0        0.04 ±105%      -0.0        0.03 ±105%  perf-profile.children.cycles-pp.is_bpf_text_address
      0.05 ±100%      -0.0        0.05 ±111%      -0.0        0.05 ± 88%  perf-profile.children.cycles-pp.rb_insert_color
      0.03 ±105%      -0.0        0.02 ±141%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.do_wait
      0.03 ±101%      -0.0        0.02 ± 99%      +0.0        0.05 ± 54%  perf-profile.children.cycles-pp.__vmalloc_node
      0.06 ± 48%      -0.0        0.05 ± 72%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.vm_area_dup
      0.07 ± 65%      -0.0        0.07 ± 49%      +0.0        0.10 ± 51%  perf-profile.children.cycles-pp.read_tsc
      9.16 ±  5%      -0.0        9.16 ±  7%      +0.0        9.17 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      2.21 ± 16%      -0.0        2.20 ± 28%      +0.2        2.36 ± 20%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.21 ± 28%      -0.0        0.21 ± 32%      -0.1        0.15 ± 25%  perf-profile.children.cycles-pp.mod_objcg_state
      0.10 ± 22%      -0.0        0.10 ± 67%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.switch_fpu_return
      0.13 ± 31%      -0.0        0.13 ± 39%      +0.0        0.15 ± 25%  perf-profile.children.cycles-pp.audit_signal_info_syscall
      0.02 ±152%      -0.0        0.02 ±142%      +0.0        0.06 ± 74%  perf-profile.children.cycles-pp.__split_vma
      0.04 ±118%      -0.0        0.04 ±112%      -0.0        0.02 ±154%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.02 ±142%      -0.0        0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp._IO_fwrite
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±154%  perf-profile.children.cycles-pp.audit_signal_info
      0.06 ± 79%      -0.0        0.06 ± 76%      +0.0        0.06 ± 45%  perf-profile.children.cycles-pp.perf_event_mmap
      0.04 ±104%      -0.0        0.03 ±163%      +0.0        0.04 ±103%  perf-profile.children.cycles-pp.legitimize_links
      0.13 ± 13%      -0.0        0.13 ± 28%      +0.0        0.14 ± 19%  perf-profile.children.cycles-pp._IO_getline_info
      0.15 ± 20%      -0.0        0.14 ± 23%      +0.0        0.17 ± 24%  perf-profile.children.cycles-pp.f2fs_write_inode
      0.66 ± 40%      -0.0        0.65 ± 10%      -0.0        0.62 ± 33%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.04 ± 71%      -0.0        0.03 ±103%      -0.0        0.02 ±153%  perf-profile.children.cycles-pp.wait4
      0.02 ±152%      -0.0        0.02 ±149%      -0.0        0.01 ±209%  perf-profile.children.cycles-pp.__x64_sys_newfstat
      0.04 ±101%      -0.0        0.03 ±106%      +0.0        0.05 ± 51%  perf-profile.children.cycles-pp.get_callchain_entry
      0.02 ±152%      -0.0        0.02 ±141%      +0.0        0.04 ± 68%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.pagevec_remove_exceptionals
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.get_user_arg_ptr
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.count
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.sync_regs
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±134%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.03 ±101%      -0.0        0.03 ±141%      -0.0        0.03 ±182%  perf-profile.children.cycles-pp.node_page_state
      0.07 ± 47%      -0.0        0.07 ± 77%      -0.0        0.07 ± 82%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.03 ±100%      -0.0        0.03 ±100%      +0.0        0.04 ± 92%  perf-profile.children.cycles-pp.process_measurement
      0.06 ± 53%      -0.0        0.06 ± 51%      -0.0        0.05 ± 70%  perf-profile.children.cycles-pp.d_lookup
      0.64 ± 19%      -0.0        0.64 ± 10%      -0.0        0.61 ± 15%  perf-profile.children.cycles-pp.tick_sched_timer
      1.23 ± 20%      -0.0        1.23 ± 14%      +0.2        1.39 ± 20%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.19 ± 23%      -0.0        0.19 ± 32%      +0.0        0.22 ± 27%  perf-profile.children.cycles-pp.f2fs_inode_dirtied
      1.14 ± 10%      +0.0        1.14 ± 21%      -0.1        1.04 ± 18%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.20 ± 36%      +0.0        0.20 ± 31%      -0.0        0.18 ± 28%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.08 ± 16%      +0.0        0.08 ± 57%      -0.0        0.06 ± 86%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.03 ±147%      +0.0        0.03 ±147%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.scsi_complete
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__is_insn_slot_addr
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xas_nomem
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__netlink_dump_start
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.netlink_rcv_skb
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.netlink_dump
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.rtnetlink_rcv_msg
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.path_get
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_accelerate_cbs_unlocked
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.getifaddrs
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.sendto
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_truncate_inline_inode
      0.11 ± 53%      +0.0        0.11 ± 95%      -0.0        0.11 ± 39%  perf-profile.children.cycles-pp.__add_ino_entry
      0.06 ± 92%      +0.0        0.06 ± 76%      +0.0        0.06 ± 68%  perf-profile.children.cycles-pp.free_pgtables
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.PyType_Ready
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.memcmp
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.note_interrupt
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.strtol@plt
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp._IO_file_xsputn
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.setattr_prepare
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.it_real_fn
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.ihold
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.finish_wait
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.scsi_decide_disposition
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.generic_file_mmap
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.sendmsg
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.ordered_events__queue
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.sg_init_table
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.__mnt_drop_write
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.__sbitmap_get_word
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.apic_ack_edge
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.end_buffer_async_write
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.__pte_alloc
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.thread__insert_map
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__xas_next
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.blk_mq_put_tag
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.sd_done
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.dso__get
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.rcu_is_watching
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.seq_put_decimal_ull_width
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.free_pgd_range
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.free_p4d_range
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.___pte_free_tlb
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__folio_lock
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.blk_mq_sched_bio_merge
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.perf_exclude_event
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp._raw_read_lock
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__blk_account_io_start
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.prepare_creds
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.setup_arg_pages
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.shift_arg_pages
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±202%  perf-profile.children.cycles-pp.switch_ldt
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.security_inode_free
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.PyObject_Malloc
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.dquot_claim_space_nodirty
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__queue_delayed_work
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__rq_qos_done_bio
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.bio_uninit
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_remove_dirty_inode
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.wbt_inflight_cb
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__fxstat@plt
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp._PyLong_New
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__init_rwsem
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__sbitmap_weight
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.from_kuid
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.scsi_device_unbusy
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.security_path_unlink
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.task_fork_fair
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__blk_account_io_done
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.proc_root_lookup
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.proc_pid_lookup
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.find_task_by_pid_ns
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.sbitmap_weight
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.dma_direct_unmap_sg
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.dma_direct_map_sg
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.list_lru_del
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.radix_tree_node_rcu_free
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_flush_inline_data
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp._IO_file_underflow
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.fscrypt_match_name
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__errno_location
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__locate_dirty_segment
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_may_inline_data
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.iov_iter_init
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp._PyObject_GenericSetAttrWithDict
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.___sys_recvmsg
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.____sys_recvmsg
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__put_anon_vma
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.fscrypt_prepare_new_inode
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.dd_has_work
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.f2fs_update_dentry
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.__mutex_init
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_statfs
      0.00            +0.0        0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.__has_merged_page
      0.00            +0.0        0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.0        0.00            +0.0        0.01 ±203%  perf-profile.children.cycles-pp.free_swap_cache
      0.00            +0.0        0.00            +0.0        0.01 ±203%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
      0.00            +0.0        0.00            +0.0        0.01 ±203%  perf-profile.children.cycles-pp.__sys_recvmsg
      0.00            +0.0        0.00            +0.0        0.01 ±203%  perf-profile.children.cycles-pp.recvmsg
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.sched_post_fork
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.00            +0.0        0.00            +0.0        0.01 ±202%  perf-profile.children.cycles-pp.cancel_delayed_work
      0.08 ± 55%      +0.0        0.08 ± 77%      +0.0        0.10 ± 83%  perf-profile.children.cycles-pp.xas_clear_mark
      0.00            +0.0        0.00            +0.0        0.02 ±204%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      0.00            +0.0        0.00            +0.0        0.02 ±152%  perf-profile.children.cycles-pp.PyDict_SetDefault
      0.00            +0.0        0.00            +0.0        0.02 ±155%  perf-profile.children.cycles-pp.in_gate_area_no_mm
      0.00            +0.0        0.00            +0.0        0.02 ±155%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.03 ±129%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.02 ±142%      +0.0        0.02 ±142%      +0.0        0.04 ± 86%  perf-profile.children.cycles-pp.__folio_memcg_unlock
      0.00            +0.0        0.00            +0.0        0.02 ±124%  perf-profile.children.cycles-pp.ahci_qc_prep
      0.00            +0.0        0.00            +0.0        0.02 ±123%  perf-profile.children.cycles-pp.fscrypt_setup_filename
      0.00            +0.0        0.00            +0.0        0.02 ±238%  perf-profile.children.cycles-pp.bio_endio
      0.00            +0.0        0.00            +0.0        0.02 ±125%  perf-profile.children.cycles-pp.__wake_up_bit
      0.14 ± 24%      +0.0        0.14 ± 53%      +0.0        0.17 ±104%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.0        0.00            +0.1        0.08 ±300%  perf-profile.children.cycles-pp.should_fail_alloc_page
      0.38 ± 10%      +0.0        0.38 ± 18%      +0.0        0.40 ± 17%  perf-profile.children.cycles-pp.__might_fault
      0.30 ±  4%      +0.0        0.30 ± 24%      +0.0        0.35 ± 57%  perf-profile.children.cycles-pp.__do_sys_clone
      0.02 ±149%      +0.0        0.02 ±145%      -0.0        0.02 ±155%  perf-profile.children.cycles-pp.f2fs_clear_page_cache_dirty_tag
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.copy_from_kernel_nofault
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.vmacache_find
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.generic_file_read_iter
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.prepend_name
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.prepend_copy
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp._copy_from_user
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.PyCode_New
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.ep_poll
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.do_epoll_wait
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.copy_string_kernel
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.page_remove_rmap
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.__get_segment_type
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±122%  perf-profile.children.cycles-pp.blk_mq_free_request
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.03 ±132%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.04 ±102%      +0.0        0.04 ± 72%      -0.0        0.03 ±103%  perf-profile.children.cycles-pp.try_to_free_buffers
      0.02 ±149%      +0.0        0.02 ±141%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.block_invalidatepage
      0.03 ±111%      +0.0        0.04 ±115%      +0.0        0.04 ± 68%  perf-profile.children.cycles-pp.radix_tree_node_alloc
      0.03 ±101%      +0.0        0.03 ±100%      +0.0        0.05 ± 85%  perf-profile.children.cycles-pp.rcu_gp_cleanup
      0.06 ± 72%      +0.0        0.06 ± 81%      +0.0        0.10 ± 51%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.14 ± 57%      +0.0        0.14 ± 28%      -0.0        0.13 ± 41%  perf-profile.children.cycles-pp.ktime_get
      0.09 ± 60%      +0.0        0.09 ± 52%      +0.0        0.09 ± 43%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.14 ± 50%      +0.0        0.14 ± 36%      +0.1        0.20 ± 83%  perf-profile.children.cycles-pp.begin_new_exec
      0.20 ± 43%      +0.0        0.20 ± 56%      -0.0        0.18 ± 19%  perf-profile.children.cycles-pp.__legitimize_path
      0.06 ± 45%      +0.0        0.06 ± 75%      +0.0        0.08 ± 61%  perf-profile.children.cycles-pp.__count_memcg_events
      0.07 ± 59%      +0.0        0.08 ± 57%      +0.0        0.09 ± 29%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.05 ±100%      +0.0        0.05 ± 73%      +0.0        0.09 ± 33%  perf-profile.children.cycles-pp.cpuacct_charge
      0.03 ±100%      +0.0        0.03 ±146%      +0.0        0.04 ± 84%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.03 ±141%      +0.0        0.03 ±146%      +0.0        0.04 ± 86%  perf-profile.children.cycles-pp.__set_nat_cache_dirty
      0.03 ±105%      +0.0        0.03 ±103%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.03 ±105%      +0.0        0.03 ±103%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.kernel_wait4
      0.02 ±141%      +0.0        0.02 ±144%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__ata_qc_complete
      0.02 ±141%      +0.0        0.02 ±144%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.ftrace_ops_trampoline
      0.02 ±141%      +0.0        0.02 ±144%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.is_ftrace_trampoline
      0.04 ±102%      +0.0        0.04 ± 72%      +0.0        0.04 ± 89%  perf-profile.children.cycles-pp.mntput
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±123%  perf-profile.children.cycles-pp.mod_zone_page_state
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±154%  perf-profile.children.cycles-pp.check_stack_object
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±123%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.03 ±101%      +0.0        0.03 ±103%      +0.0        0.05 ±116%  perf-profile.children.cycles-pp._dl_addr
      0.11 ± 53%      +0.0        0.11 ± 90%      -0.0        0.11 ± 39%  perf-profile.children.cycles-pp.f2fs_add_orphan_inode
      0.43 ± 18%      +0.0        0.43 ± 16%      +0.0        0.46 ± 21%  perf-profile.children.cycles-pp.scheduler_tick
      0.08 ± 54%      +0.0        0.08 ± 56%      +0.0        0.09 ± 42%  perf-profile.children.cycles-pp.errseq_sample
      0.03 ±102%      +0.0        0.03 ±100%      +0.0        0.04 ± 92%  perf-profile.children.cycles-pp.file_remove_privs
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±213%  perf-profile.children.cycles-pp.info_print_ext_header
      0.02 ±223%      +0.0        0.02 ±142%      +0.0        0.03 ±162%  perf-profile.children.cycles-pp.rcu_accelerate_cbs
      0.02 ±223%      +0.0        0.02 ±142%      +0.0        0.06 ± 42%  perf-profile.children.cycles-pp.timestamp_truncate
      0.30 ± 33%      +0.0        0.31 ± 30%      -0.0        0.28 ± 20%  perf-profile.children.cycles-pp.try_to_unlazy
      0.03 ±150%      +0.0        0.04 ±101%      -0.0        0.02 ±203%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.04 ± 75%      +0.0        0.05 ± 88%      -0.0        0.03 ±104%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.10 ± 20%      +0.0        0.11 ± 60%      -0.0        0.09 ± 43%  perf-profile.children.cycles-pp.zap_pte_range
      0.20 ± 16%      +0.0        0.21 ± 37%      -0.0        0.20 ± 20%  perf-profile.children.cycles-pp.@plt
      0.03 ±103%      +0.0        0.04 ± 72%      +0.0        0.04 ± 86%  perf-profile.children.cycles-pp.slab_show
      0.03 ±101%      +0.0        0.04 ±100%      +0.0        0.05 ± 87%  perf-profile.children.cycles-pp.get_partial_node
      0.07 ± 83%      +0.0        0.07 ± 50%      +0.0        0.10 ± 53%  perf-profile.children.cycles-pp.perf_event_pid_type
      0.12 ± 59%      +0.0        0.13 ± 12%      +0.0        0.12 ± 58%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.19 ± 19%      +0.0        0.20 ± 27%      -0.0        0.18 ± 22%  perf-profile.children.cycles-pp.do_fault
      0.15 ± 39%      +0.0        0.16 ± 13%      -0.0        0.14 ± 37%  perf-profile.children.cycles-pp.f2fs_init_acl
      0.36 ±  8%      +0.0        0.37 ± 15%      +0.0        0.40 ± 51%  perf-profile.children.cycles-pp.__libc_fork
      0.04 ± 73%      +0.0        0.05 ±100%      -0.0        0.02 ±154%  perf-profile.children.cycles-pp.rb_next
      0.02 ±143%      +0.0        0.03 ±101%      -0.0        0.01 ±202%  perf-profile.children.cycles-pp.tag_pages_for_writeback
      0.01 ±223%      +0.0        0.02 ±142%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp._find_first_bit
      0.03 ±111%      +0.0        0.04 ± 72%      -0.0        0.02 ±154%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.06 ± 89%      +0.0        0.07 ± 80%      +0.0        0.06 ±116%  perf-profile.children.cycles-pp.xas_init_marks
      0.02 ±141%      +0.0        0.02 ±141%      +0.0        0.03 ±123%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.03 ±158%      +0.0        0.04 ±105%      -0.0        0.01 ±202%  perf-profile.children.cycles-pp.bpf_ksym_find
      0.03 ±141%      +0.0        0.04 ±141%      +0.0        0.07 ± 71%  perf-profile.children.cycles-pp.d_splice_alias
      0.04 ± 73%      +0.0        0.05 ± 76%      +0.0        0.06 ± 58%  perf-profile.children.cycles-pp.__mmap
      0.36 ± 17%      +0.0        0.37 ± 22%      +0.1        0.46 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock
      1.44 ±  4%      +0.0        1.45 ± 12%      +0.1        1.55 ± 10%  perf-profile.children.cycles-pp.__alloc_file
      0.06 ± 49%      +0.0        0.07 ± 57%      -0.0        0.04 ±104%  perf-profile.children.cycles-pp.timekeeping_advance
      0.06 ± 49%      +0.0        0.07 ± 57%      -0.0        0.04 ±103%  perf-profile.children.cycles-pp.update_wall_time
      0.13 ± 29%      +0.0        0.14 ± 30%      +0.0        0.14 ± 36%  perf-profile.children.cycles-pp.filemap_map_pages
      0.02 ±141%      +0.0        0.03 ±150%      +0.0        0.04 ± 80%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.19 ± 25%      +0.0        0.20 ± 43%      +0.0        0.24 ± 19%  perf-profile.children.cycles-pp.check_kill_permission
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.f2fs_submit_page_bio
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.locks_remove_posix
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.scsi_done
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.locked_inode_to_wb_and_lock_list
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.perf_evsel__parse_id_sample
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.widen_string
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.evsel__parse_sample_timestamp
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.rtnl_dump_ifinfo
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.rtnl_fill_ifinfo
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.schedule_tail
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.lockref_get_not_zero
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.rcu_segcblist_accelerate
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.open_exec
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__dsos__findnew_link_by_longname_id
      0.01 ±223%      +0.0        0.02 ±144%      +0.0        0.01 ±203%  perf-profile.children.cycles-pp.do_statfs_native
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.kvm_is_in_guest
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.bio_free
      0.01 ±223%      +0.0        0.02 ±223%      +0.0        0.02 ±213%  perf-profile.children.cycles-pp.f2fs_target_device
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.perf_misc_flags
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.sbitmap_queue_clear
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_flush_nat_entries
      0.01 ±223%      +0.0        0.02 ±223%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.readdir@plt
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.02 ±156%  perf-profile.children.cycles-pp.snprintf
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.inode_sb_list_add
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp._IO_setvbuf
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±124%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.00            +0.0        0.01 ±223%      +0.0        0.03 ±128%  perf-profile.children.cycles-pp.scsi_finish_command
      0.05 ± 74%      +0.0        0.06 ± 75%      -0.0        0.03 ±129%  perf-profile.children.cycles-pp.thread__fork
      0.03 ±102%      +0.0        0.04 ±102%      -0.0        0.01 ±203%  perf-profile.children.cycles-pp.maps__clone
      0.07 ± 74%      +0.0        0.08 ± 80%      +0.0        0.09 ± 34%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.02 ± 99%      +0.0        0.04 ±105%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.filemap_alloc_folio
      0.02 ±144%      +0.0        0.03 ±101%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.page_counter_cancel
      0.01 ±223%      +0.0        0.02 ±144%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.f2fs_ra_meta_pages
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.radix_tree_lookup
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.get_unmapped_area
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.bio_attempt_back_merge
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.workingset_update_node
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.unlink_file_vma
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.__rq_qos_done
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±154%  perf-profile.children.cycles-pp.__note_gp_changes
      0.04 ±106%      +0.0        0.05 ± 73%      -0.0        0.02 ±124%  perf-profile.children.cycles-pp.find_vma
      0.02 ±223%      +0.0        0.03 ±155%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.lockref_get_not_dead
      1.11 ± 26%      +0.0        1.12 ± 41%      -0.2        0.92 ± 22%  perf-profile.children.cycles-pp.step_into
      0.20 ± 33%      +0.0        0.21 ± 22%      -0.0        0.20 ± 14%  perf-profile.children.cycles-pp.down_write
      0.18 ± 27%      +0.0        0.19 ± 23%      +0.0        0.19 ± 20%  perf-profile.children.cycles-pp._PyEval_EvalFrameDefault
      0.14 ± 31%      +0.0        0.15 ± 32%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.f2fs_init_extent_tree
      0.26 ±  9%      +0.0        0.27 ± 28%      +0.1        0.31 ± 14%  perf-profile.children.cycles-pp.vfs_rename
      0.29 ± 20%      +0.0        0.30 ± 24%      +0.1        0.37 ± 15%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.02 ±142%      +0.0        0.03 ±100%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__radix_tree_delete
      0.02 ±142%      +0.0        0.03 ±101%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.timekeeping_update
      0.01 ±223%      +0.0        0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.folio_mkclean
      0.01 ±223%      +0.0        0.02 ±142%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.node_tag_clear
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.PyParser_AddToken
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__bio_try_merge_page
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.current_umask
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.kthread_should_stop
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.page_mapping
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.open@plt
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.pread@plt
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.PyObject_RichCompare
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.apparmor_path_rename
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.bit_cursor
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.expand_downwards
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.security_path_rename
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.soft_cursor
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__vma_link_rb
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_newstat
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.fib_table_lookup
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.console_conditional_schedule
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.ip_route_input_noref
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.ip_route_input_rcu
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.ip_route_input_slow
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.map_vdso
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__install_special_mapping
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.proc_ns_dir_lookup
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.proc_ns_instantiate
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.perf_output_end
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.__do_fault
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.do_open_execat
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.openat64
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.proc_pid_make_inode
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__clear_user
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.xattr_resolve_name
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.d_lru_del
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.submit_flush_wait
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__vsnprintf_chk
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.perf_output_put_handle
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.children.cycles-pp.__send_signal
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.children.cycles-pp.signal_wake_up_state
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±203%  perf-profile.children.cycles-pp.sd_event_run
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.inode_init_always
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±157%  perf-profile.children.cycles-pp.vfprintf
      0.02 ±141%      +0.0        0.04 ±100%      +0.0        0.04 ±104%  perf-profile.children.cycles-pp.fscrypt_fname_free_buffer
      0.04 ±146%      +0.0        0.05 ± 47%      -0.0        0.03 ±103%  perf-profile.children.cycles-pp.memalign@plt
      0.08 ± 35%      +0.0        0.09 ± 26%      +0.0        0.10 ± 30%  perf-profile.children.cycles-pp.__libc_calloc
      0.15 ± 38%      +0.0        0.16 ± 21%      +0.0        0.16 ± 24%  perf-profile.children.cycles-pp.map_id_up
      0.41 ± 96%      +0.0        0.42 ± 73%      +0.1        0.49 ± 45%  perf-profile.children.cycles-pp.poll_idle
      1.57 ±  3%      +0.0        1.58 ± 11%      +0.1        1.67 ± 10%  perf-profile.children.cycles-pp.alloc_empty_file
      0.47 ± 31%      +0.0        0.48 ± 18%      +0.2        0.64 ± 28%  perf-profile.children.cycles-pp.folio_add_lru
      0.27 ± 42%      +0.0        0.28 ± 24%      -0.0        0.26 ± 17%  perf-profile.children.cycles-pp.complete_walk
      0.34 ± 18%      +0.0        0.35 ± 23%      +0.0        0.35 ± 26%  perf-profile.children.cycles-pp.readdir64
      0.51 ± 24%      +0.0        0.52 ± 14%      +0.2        0.68 ± 28%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.10 ± 37%      +0.0        0.11 ± 35%      +0.0        0.12 ± 36%  perf-profile.children.cycles-pp.__activate_page
      0.11 ± 38%      +0.0        0.12 ± 22%      +0.1        0.18 ±106%  perf-profile.children.cycles-pp.setlocale
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.fbcon_cursor
      0.01 ±223%      +0.0        0.02 ±142%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.machine__findnew_vdso
      0.01 ±223%      +0.0        0.02 ±146%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp._PyFunction_FastCallKeywords
      0.00            +0.0        0.01 ±223%      +0.0        0.04 ± 83%  perf-profile.children.cycles-pp.set_page_dirty
      0.42 ± 10%      +0.0        0.43 ± 18%      -0.0        0.38 ± 21%  perf-profile.children.cycles-pp.__might_sleep
      0.87 ± 12%      +0.0        0.89 ± 18%      -0.1        0.82 ± 16%  perf-profile.children.cycles-pp.enqueue_entity
      0.22 ± 56%      +0.0        0.23 ± 34%      -0.0        0.19 ± 29%  perf-profile.children.cycles-pp.node_dirty_ok
      0.04 ±107%      +0.0        0.05 ± 80%      -0.0        0.03 ±103%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.04 ±112%      +0.0        0.05 ± 83%      -0.0        0.01 ±206%  perf-profile.children.cycles-pp.may_delete
      0.06 ± 19%      +0.0        0.08 ± 27%      +0.0        0.06 ± 60%  perf-profile.children.cycles-pp.fd_install
      0.03 ±100%      +0.0        0.05 ± 71%      +0.0        0.04 ±102%  perf-profile.children.cycles-pp.__blk_mq_end_request
      0.01 ±223%      +0.0        0.02 ±143%      +0.0        0.01 ±201%  perf-profile.children.cycles-pp.inode_init_once
      0.02 ±144%      +0.0        0.04 ±100%      -0.0        0.02 ±153%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__get_user_pages
      0.96 ± 15%      +0.0        0.98 ± 15%      +0.2        1.20 ± 39%  perf-profile.children.cycles-pp.__close
      0.08 ± 58%      +0.0        0.10 ± 51%      -0.0        0.06 ± 71%  perf-profile.children.cycles-pp.__enqueue_entity
      0.25 ± 25%      +0.0        0.27 ± 23%      +0.1        0.32 ± 16%  perf-profile.children.cycles-pp.f2fs_update_inode_page
      0.00            +0.0        0.02 ±223%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.kill@plt
      0.06 ± 76%      +0.0        0.07 ± 47%      -0.0        0.04 ±104%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.01 ±223%      +0.0        0.03 ±143%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.bio_associate_blkg_from_css
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±203%  perf-profile.children.cycles-pp.add_interrupt_randomness
      0.03 ±155%      +0.0        0.05 ±109%      +0.0        0.05 ± 53%  perf-profile.children.cycles-pp.elf_map
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.04 ±107%  perf-profile.children.cycles-pp.strstr@plt
      0.11 ± 70%      +0.0        0.13 ± 58%      +0.0        0.12 ± 29%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.48 ± 10%      +0.0        0.49 ± 24%      -0.1        0.42 ± 16%  perf-profile.children.cycles-pp.xas_start
      0.28 ± 20%      +0.0        0.30 ± 35%      +0.1        0.34 ± 51%  perf-profile.children.cycles-pp.load_elf_binary
      0.06 ±119%      +0.0        0.08 ± 60%      -0.0        0.05 ± 68%  perf-profile.children.cycles-pp.pid_task
      0.02 ±142%      +0.0        0.04 ± 73%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.get_node_path
      0.01 ±223%      +0.0        0.03 ±223%      +0.0        0.02 ±156%  perf-profile.children.cycles-pp.vma_link
      0.00            +0.0        0.02 ±142%      +0.0        0.01 ±201%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.01 ±223%      +0.0        0.03 ±143%      +0.0        0.04 ± 87%  perf-profile.children.cycles-pp.page_counter_charge
      0.05 ± 76%      +0.0        0.07 ± 54%      +0.0        0.08 ± 41%  perf-profile.children.cycles-pp.refill_obj_stock
      0.01 ±223%      +0.0        0.03 ±143%      +0.0        0.04 ± 68%  perf-profile.children.cycles-pp.__d_lookup_done
      0.05 ± 76%      +0.0        0.07 ± 81%      +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.02 ±141%      +0.0        0.04 ±109%      +0.0        0.04 ±106%  perf-profile.children.cycles-pp.copy_page
      0.02 ±142%      +0.0        0.04 ±100%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.from_kgid_munged
      0.31 ± 25%      +0.0        0.33 ± 41%      +0.1        0.40 ± 22%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.22 ± 34%      +0.0        0.24 ± 29%      +0.2        0.45 ±116%  perf-profile.children.cycles-pp.free_unref_page_list
      0.02 ±141%      +0.0        0.04 ±107%      -0.0        0.02 ±154%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.00            +0.0        0.02 ±144%      +0.0        0.00        perf-profile.children.cycles-pp.mod_node_page_state
      0.00            +0.0        0.02 ±144%      +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_readlink
      0.00            +0.0        0.02 ±144%      +0.0        0.00        perf-profile.children.cycles-pp.dsos__findnew_id
      0.00            +0.0        0.02 ±144%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +0.0        0.02 ±144%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.dentry_needs_remove_privs
      0.00            +0.0        0.02 ±144%      +0.0        0.01 ±209%  perf-profile.children.cycles-pp.__fprop_add_percpu
      0.00            +0.0        0.02 ±144%      +0.0        0.02 ±156%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.06 ± 56%      +0.0        0.08 ± 56%      +0.0        0.07 ± 38%  perf-profile.children.cycles-pp.deactivate_file_page
      0.06 ± 74%      +0.0        0.08 ± 72%      +0.0        0.08 ± 25%  perf-profile.children.cycles-pp.__strdup
      0.69 ± 12%      +0.0        0.71 ± 40%      -0.1        0.62 ± 16%  perf-profile.children.cycles-pp.dput
      1.29 ± 11%      +0.0        1.31 ± 16%      +0.1        1.40 ±  5%  perf-profile.children.cycles-pp.rcu_core
      0.95 ± 10%      +0.0        0.97 ± 10%      +0.0        0.98 ± 12%  perf-profile.children.cycles-pp.strncpy_from_user
      0.52 ± 17%      +0.0        0.54 ± 18%      +0.1        0.58 ± 32%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.02 ±141%      +0.0        0.05 ± 77%      +0.0        0.04 ± 83%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.08 ± 25%      +0.0        0.10 ± 30%      -0.0        0.08 ± 47%  perf-profile.children.cycles-pp.bitfill_aligned
      0.08 ± 25%      +0.0        0.10 ± 30%      -0.0        0.08 ± 46%  perf-profile.children.cycles-pp.bit_clear
      0.08 ± 25%      +0.0        0.10 ± 30%      -0.0        0.08 ± 46%  perf-profile.children.cycles-pp.cfb_fillrect
      0.00            +0.0        0.02 ±142%      +0.0        0.00        perf-profile.children.cycles-pp.prepare_to_swait_event
      0.00            +0.0        0.02 ±142%      +0.0        0.00        perf-profile.children.cycles-pp.do_notify_parent
      0.01 ±223%      +0.0        0.03 ±101%      +0.0        0.01 ±209%  perf-profile.children.cycles-pp.__fprop_add_percpu_max
      0.03 ±142%      +0.0        0.05 ± 76%      +0.0        0.04 ± 90%  perf-profile.children.cycles-pp.f2fs_lookup_rb_tree
      0.03 ±141%      +0.0        0.06 ± 86%      +0.0        0.04 ± 89%  perf-profile.children.cycles-pp.unlock_page
      0.04 ± 76%      +0.0        0.06 ± 81%      +0.0        0.06 ± 60%  perf-profile.children.cycles-pp.security_task_getsecid_subj
      0.00            +0.0        0.02 ±142%      +0.0        0.02 ±159%  perf-profile.children.cycles-pp._PyDict_LoadGlobal
      0.01 ±223%      +0.0        0.04 ±109%      +0.0        0.04 ±121%  perf-profile.children.cycles-pp.ip_sublist_rcv
      0.01 ±223%      +0.0        0.04 ±109%      +0.0        0.04 ±116%  perf-profile.children.cycles-pp.ip_list_rcv
      0.98 ± 16%      +0.0        1.00 ± 17%      +0.1        1.12 ± 43%  perf-profile.children.cycles-pp.__fput
      0.74 ± 12%      +0.0        0.77 ± 14%      -0.1        0.67 ± 10%  perf-profile.children.cycles-pp.find_lock_entries
      0.25 ± 25%      +0.0        0.28 ± 17%      +0.1        0.32 ± 14%  perf-profile.children.cycles-pp.filp_close
      0.18 ± 37%      +0.0        0.20 ± 25%      +0.1        0.32 ± 65%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.01 ±223%      +0.0        0.03 ±103%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.get_arg_page
      0.01 ±223%      +0.0        0.03 ±103%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__get_user_pages_remote
      0.12 ± 14%      +0.0        0.14 ± 26%      +0.0        0.13 ± 23%  perf-profile.children.cycles-pp.f2fs_sync_node_pages
      0.10 ± 62%      +0.0        0.12 ± 26%      +0.0        0.12 ± 31%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.02 ±141%      +0.0        0.04 ± 72%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.00            +0.0        0.02 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.string_nocheck
      0.02 ±149%      +0.0        0.05 ±117%      +0.0        0.03 ±124%  perf-profile.children.cycles-pp.next_uptodate_page
      0.00            +0.0        0.02 ±141%      +0.0        0.02 ±155%  perf-profile.children.cycles-pp.ima_file_free
      0.03 ±100%      +0.0        0.05 ± 76%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.f2fs_build_free_nids
      0.27 ± 22%      +0.0        0.30 ± 27%      +0.3        0.54 ±102%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.01 ±223%      +0.0        0.03 ±111%      +0.0        0.02 ±177%  perf-profile.children.cycles-pp.statfs_by_dentry
      0.07 ± 54%      +0.0        0.10 ± 65%      +0.0        0.10 ± 28%  perf-profile.children.cycles-pp.xas_alloc
      0.06 ± 52%      +0.0        0.09 ± 65%      -0.0        0.06 ± 76%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.0        0.03 ±155%      +0.0        0.00        perf-profile.children.cycles-pp.__rblist__findnew
      0.02 ±144%      +0.0        0.05 ± 71%      +0.0        0.03 ±127%  perf-profile.children.cycles-pp.f2fs_try_convert_inline_dir
      0.09 ± 60%      +0.0        0.12 ± 24%      -0.0        0.08 ± 50%  perf-profile.children.cycles-pp.end_bio_bh_io_sync
      0.01 ±223%      +0.0        0.04 ± 72%      +0.0        0.01 ±203%  perf-profile.children.cycles-pp.bio_add_page
      0.17 ± 28%      +0.0        0.20 ± 14%      +0.0        0.19 ± 22%  perf-profile.children.cycles-pp._IO_fgets
      0.05 ± 56%      +0.0        0.08 ± 21%      +0.0        0.07 ± 51%  perf-profile.children.cycles-pp.should_failslab
      0.10 ± 30%      +0.0        0.13 ± 62%      -0.0        0.10 ± 43%  perf-profile.children.cycles-pp.xa_get_order
      0.05 ± 45%      +0.0        0.08 ± 59%      -0.0        0.05 ± 83%  perf-profile.children.cycles-pp.copy_strings
      0.02 ±142%      +0.0        0.05 ±100%      +0.0        0.04 ±113%  perf-profile.children.cycles-pp.copy_pte_range
      0.04 ± 72%      +0.0        0.07 ± 12%      +0.0        0.07 ± 67%  perf-profile.children.cycles-pp.file_update_time
      0.07 ± 58%      +0.0        0.10 ± 33%      +0.0        0.07 ± 46%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09 ± 61%      +0.0        0.12 ± 51%      +0.0        0.14 ± 27%  perf-profile.children.cycles-pp.ima_file_check
      0.00            +0.0        0.03 ±101%      +0.0        0.00        perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.0        0.03 ±146%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.vfs_open
      0.03 ±163%      +0.0        0.06 ± 73%      +0.0        0.05 ± 71%  perf-profile.children.cycles-pp.gettimeofday@plt
      0.08 ± 84%      +0.0        0.11 ± 14%      +0.0        0.10 ± 31%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.01 ±223%      +0.0        0.04 ±110%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.02 ±142%      +0.0        0.05 ± 75%      +0.0        0.03 ±119%  perf-profile.children.cycles-pp.vfs_statfs
      0.06 ± 82%      +0.0        0.09 ± 24%      +0.0        0.10 ± 46%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.29 ± 18%      +0.0        0.32 ± 31%      +0.1        0.35 ± 50%  perf-profile.children.cycles-pp.exec_binprm
      0.22 ± 14%      +0.0        0.26 ± 30%      -0.0        0.21 ± 15%  perf-profile.children.cycles-pp.__get_meta_page
      0.18 ± 18%      +0.0        0.22 ± 25%      +0.0        0.19 ± 31%  perf-profile.children.cycles-pp.rcu_all_qs
      0.17 ± 23%      +0.0        0.20 ± 54%      +0.0        0.22 ± 25%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.0        0.03 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.string
      0.00            +0.0        0.03 ±102%      +0.0        0.00        perf-profile.children.cycles-pp.do_readlinkat
      0.02 ±141%      +0.0        0.05 ± 80%      +0.0        0.04 ± 68%  perf-profile.children.cycles-pp.iput
      0.80 ± 13%      +0.0        0.83 ±  8%      +0.0        0.81 ± 14%  perf-profile.children.cycles-pp.make_kuid
      1.22 ± 17%      +0.0        1.25 ± 20%      +0.0        1.26 ± 15%  perf-profile.children.cycles-pp.xas_find_marked
      0.40 ± 23%      +0.0        0.44 ± 76%      +0.0        0.42 ± 19%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      0.33 ± 71%      +0.0        0.36 ± 78%      +0.0        0.35 ± 70%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.33 ± 71%      +0.0        0.36 ± 78%      +0.0        0.35 ± 70%  perf-profile.children.cycles-pp.devkmsg_emit
      0.01 ±223%      +0.0        0.04 ± 72%      -0.0        0.00        perf-profile.children.cycles-pp.enqueue_hrtimer
      0.01 ±223%      +0.0        0.05 ± 47%      +0.0        0.02 ±126%  perf-profile.children.cycles-pp.proc_pid_status
      0.01 ±223%      +0.0        0.04 ±104%      +0.0        0.04 ±100%  perf-profile.children.cycles-pp.kfree
      0.01 ±223%      +0.0        0.04 ± 75%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.policy_node
      0.22 ± 49%      +0.0        0.26 ± 24%      +0.2        0.39 ±114%  perf-profile.children.cycles-pp.blkdev_close
      0.22 ± 49%      +0.0        0.26 ± 24%      +0.2        0.39 ±114%  perf-profile.children.cycles-pp.blkdev_put
      0.22 ± 49%      +0.0        0.26 ± 24%      +0.2        0.39 ±114%  perf-profile.children.cycles-pp.blkdev_flush_mapping
      0.06 ± 78%      +0.0        0.09 ± 55%      +0.0        0.06 ± 71%  perf-profile.children.cycles-pp.up_read
      0.01 ±223%      +0.0        0.05 ± 74%      +0.0        0.06 ± 87%  perf-profile.children.cycles-pp.__perf_sw_event
      0.38 ± 17%      +0.0        0.42 ± 15%      +0.1        0.44 ± 15%  perf-profile.children.cycles-pp.__check_object_size
      1.45 ± 13%      +0.0        1.49 ± 11%      +0.1        1.60 ±  8%  perf-profile.children.cycles-pp.getname_flags
      0.02 ±143%      +0.0        0.06 ± 81%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.__set_data_blkaddr
      0.00            +0.0        0.04 ±102%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.05 ±120%      +0.0        0.08 ± 75%      +0.0        0.08 ± 51%  perf-profile.children.cycles-pp.f2fs_prepare_lookup
      0.09 ± 34%      +0.0        0.13 ± 25%      +0.0        0.13 ± 31%  perf-profile.children.cycles-pp.dnotify_flush
      0.01 ±223%      +0.0        0.05 ±111%      +0.0        0.05 ± 58%  perf-profile.children.cycles-pp.free@plt
      0.31 ± 18%      +0.0        0.35 ± 18%      +0.0        0.36 ± 23%  perf-profile.children.cycles-pp.memset_erms
      0.76 ± 17%      +0.0        0.80 ±  8%      -0.0        0.75 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.40 ± 12%      +0.0        0.44 ± 18%      -0.0        0.39 ± 11%  perf-profile.children.cycles-pp.xas_find
      0.04 ±102%      +0.0        0.08 ± 59%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.strncasecmp
      0.02 ±141%      +0.0        0.06 ± 86%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.01 ±223%      +0.0        0.05 ±106%      +0.0        0.06 ± 96%  perf-profile.children.cycles-pp.__netif_receive_skb_list_core
      0.06 ± 75%      +0.0        0.09 ± 26%      +0.0        0.08 ± 42%  perf-profile.children.cycles-pp.xas_set_mark
      0.10 ± 61%      +0.0        0.14 ± 30%      +0.0        0.11 ± 56%  perf-profile.children.cycles-pp.f2fs_get_block
      0.01 ±223%      +0.0        0.05 ±104%      +0.1        0.07 ± 86%  perf-profile.children.cycles-pp.netif_receive_skb_list_internal
      0.01 ±223%      +0.0        0.05 ±104%      +0.1        0.07 ± 85%  perf-profile.children.cycles-pp.gro_normal_list
      0.20 ± 25%      +0.0        0.24 ± 16%      +0.0        0.24 ± 20%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.13 ±  4%      +0.0        1.17 ± 18%      +0.1        1.19 ± 21%  perf-profile.children.cycles-pp.__might_resched
      0.02 ±152%      +0.0        0.07 ± 82%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.blk_mq_sched_try_merge
      0.02 ±142%      +0.0        0.06 ± 46%      +0.0        0.02 ±162%  perf-profile.children.cycles-pp.f2fs_lookup_extent_cache
      0.02 ±142%      +0.0        0.06 ± 54%      +0.0        0.03 ±128%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.03 ±144%      +0.0        0.07 ± 79%      +0.0        0.03 ±129%  perf-profile.children.cycles-pp.dd_bio_merge
      0.15 ± 31%      +0.0        0.19 ± 21%      -0.0        0.14 ± 44%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.22 ± 23%      +0.0        0.26 ± 22%      +0.0        0.26 ± 14%  perf-profile.children.cycles-pp.__virt_addr_valid
      1.07 ± 20%      +0.0        1.12 ± 32%      +0.1        1.13 ± 11%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      0.00            +0.0        0.04 ±156%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.format_decode
      0.00            +0.0        0.04 ±103%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.symbol__is_idle
      0.01 ±223%      +0.0        0.06 ± 57%      +0.0        0.02 ±126%  perf-profile.children.cycles-pp.proc_single_show
      0.00            +0.0        0.04 ± 73%      +0.0        0.02 ±124%  perf-profile.children.cycles-pp.unmap_region
      0.00            +0.0        0.04 ± 73%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.up_write
      0.01 ±223%      +0.0        0.06 ±103%      +0.1        0.07 ± 81%  perf-profile.children.cycles-pp.napi_complete_done
      0.36 ± 28%      +0.0        0.41 ± 22%      +0.1        0.44 ± 39%  perf-profile.children.cycles-pp.pipe_write
      0.23 ± 24%      +0.0        0.28 ± 17%      -0.0        0.23 ± 16%  perf-profile.children.cycles-pp.f2fs_reserve_new_blocks
      6.18 ±  5%      +0.0        6.22 ± 18%      -0.1        6.06 ±  9%  perf-profile.children.cycles-pp.handle_irq_event
      0.52 ± 24%      +0.0        0.56 ± 38%      +0.1        0.62 ± 16%  perf-profile.children.cycles-pp.swake_up_one
      0.16 ± 31%      +0.0        0.21 ± 29%      -0.0        0.16 ± 33%  perf-profile.children.cycles-pp.__xa_set_mark
      0.47 ± 10%      +0.0        0.52 ± 22%      -0.1        0.41 ± 14%  perf-profile.children.cycles-pp.pipe_read
      0.98 ± 10%      +0.0        1.03 ±  9%      -0.0        0.94 ±  4%  perf-profile.children.cycles-pp.drop_pagecache_sb
      0.98 ± 10%      +0.0        1.03 ±  9%      -0.0        0.94 ±  4%  perf-profile.children.cycles-pp.iterate_supers
      0.08 ± 57%      +0.0        0.13 ± 13%      +0.0        0.09 ± 26%  perf-profile.children.cycles-pp.f2fs_alloc_nid
      1.60 ± 45%      +0.0        1.64 ± 35%      +0.2        1.78 ± 53%  perf-profile.children.cycles-pp.blkdev_write_iter
      0.99 ±  9%      +0.0        1.04 ±  8%      -0.0        0.94 ±  4%  perf-profile.children.cycles-pp.drop_caches_sysctl_handler
      0.99 ± 20%      +0.0        1.04 ± 34%      +0.0        1.02 ± 11%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      0.00            +0.0        0.05 ± 74%      +0.0        0.02 ±123%  perf-profile.children.cycles-pp.__vm_munmap
      0.83 ±  9%      +0.0        0.88 ± 37%      -0.0        0.81 ± 16%  perf-profile.children.cycles-pp.f2fs_map_blocks
      0.15 ± 22%      +0.0        0.20 ± 39%      +0.0        0.19 ± 15%  perf-profile.children.cycles-pp.xas_create
      0.20 ± 39%      +0.1        0.26 ± 26%      +0.1        0.29 ± 58%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.30 ± 19%      +0.1        0.35 ± 27%      +0.1        0.36 ± 49%  perf-profile.children.cycles-pp.bprm_execve
      0.05 ±100%      +0.1        0.10 ± 41%      +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.___perf_sw_event
      0.09 ± 78%      +0.1        0.14 ± 33%      +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.05 ± 90%      +0.1        0.10 ± 60%      +0.0        0.08 ± 71%  perf-profile.children.cycles-pp.close_fd
      0.05 ± 77%      +0.1        0.10 ± 23%      +0.0        0.09 ± 61%  perf-profile.children.cycles-pp.down_read_killable
      0.00            +0.1        0.06 ±110%      +0.0        0.02 ±216%  perf-profile.children.cycles-pp.number
      0.02 ±223%      +0.1        0.08 ± 79%      +0.1        0.12 ± 72%  perf-profile.children.cycles-pp.igb_poll
      0.02 ±223%      +0.1        0.08 ± 79%      +0.1        0.12 ± 72%  perf-profile.children.cycles-pp.__napi_poll
      6.09 ±  5%      +0.1        6.15 ± 18%      -0.1        5.99 ±  9%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.10 ± 33%      +0.1        0.16 ± 16%      +0.1        0.18 ±114%  perf-profile.children.cycles-pp.restore_nameidata
      0.07 ± 83%      +0.1        0.13 ± 24%      +0.0        0.12 ± 37%  perf-profile.children.cycles-pp.wp_page_copy
      0.24 ± 45%      +0.1        0.30 ± 28%      +0.1        0.31 ± 21%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.10 ± 44%      +0.1        0.16 ± 53%      -0.0        0.07 ± 54%  perf-profile.children.cycles-pp.call_timer_fn
      0.07 ± 78%      +0.1        0.13 ± 44%      +0.0        0.09 ± 25%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.26 ± 29%      +0.1        0.32 ± 11%      -0.0        0.26 ± 21%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.10 ± 44%      +0.1        0.17 ± 48%      -0.0        0.08 ± 55%  perf-profile.children.cycles-pp.run_timer_softirq
      0.02 ±223%      +0.1        0.08 ± 78%      +0.1        0.12 ± 74%  perf-profile.children.cycles-pp.net_rx_action
      0.52 ±  5%      +0.1        0.59 ± 37%      -0.0        0.49 ± 17%  perf-profile.children.cycles-pp.f2fs_get_dnode_of_data
      6.16 ±  5%      +0.1        6.22 ± 18%      -0.1        6.04 ±  9%  perf-profile.children.cycles-pp.handle_irq_event_percpu
      0.13 ± 58%      +0.1        0.19 ± 37%      +0.0        0.14 ± 39%  perf-profile.children.cycles-pp.f2fs_balance_fs
      0.00            +0.1        0.06 ±141%      +0.0        0.02 ±299%  perf-profile.children.cycles-pp.kallsyms_expand_symbol
      0.00            +0.1        0.07 ±144%      +0.0        0.02 ±300%  perf-profile.children.cycles-pp.s_next
      0.96 ± 32%      +0.1        1.03 ± 33%      -0.1        0.84 ± 13%  perf-profile.children.cycles-pp.f2fs_new_node_page
      0.13 ± 35%      +0.1        0.20 ±158%      +0.1        0.22 ±118%  perf-profile.children.cycles-pp.__block_commit_write
      0.32 ± 25%      +0.1        0.40 ± 14%      +0.1        0.41 ± 14%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.07 ±148%      +0.0        0.02 ±300%  perf-profile.children.cycles-pp.update_iter
      0.13 ± 35%      +0.1        0.20 ±159%      +0.1        0.22 ±118%  perf-profile.children.cycles-pp.block_write_end
      0.12 ± 46%      +0.1        0.19 ±173%      +0.1        0.20 ±129%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.47 ± 11%      +0.1        0.55 ± 23%      +0.1        0.53 ± 20%  perf-profile.children.cycles-pp.xas_store
      0.38 ± 15%      +0.1        0.45 ± 61%      +0.0        0.40 ± 13%  perf-profile.children.cycles-pp.read_node_page
      6.63 ±  9%      +0.1        6.70 ±  8%      +0.2        6.86 ±  5%  perf-profile.children.cycles-pp.open64
      0.97 ± 31%      +0.1        1.04 ± 34%      -0.1        0.85 ± 13%  perf-profile.children.cycles-pp.f2fs_new_inode_page
      0.33 ±  5%      +0.1        0.41 ± 11%      +0.0        0.34 ± 10%  perf-profile.children.cycles-pp.build_sit_entries
      0.18 ± 34%      +0.1        0.26 ± 20%      +0.1        0.26 ± 18%  perf-profile.children.cycles-pp.cfree
      0.39 ± 12%      +0.1        0.47 ± 20%      +0.1        0.46 ± 40%  perf-profile.children.cycles-pp.execve
      0.39 ± 14%      +0.1        0.47 ± 20%      +0.1        0.46 ± 40%  perf-profile.children.cycles-pp.do_execveat_common
      0.02 ±141%      +0.1        0.10 ±223%      +0.0        0.02 ±163%  perf-profile.children.cycles-pp.__dd_dispatch_request
      0.02 ±223%      +0.1        0.10 ± 65%      +0.0        0.06 ± 86%  perf-profile.children.cycles-pp.pick_file
      0.02 ±146%      +0.1        0.10 ± 59%      +0.0        0.05 ± 78%  perf-profile.children.cycles-pp.map__new
      1.20 ± 28%      +0.1        1.28 ± 30%      -0.1        1.06 ± 14%  perf-profile.children.cycles-pp.f2fs_init_inode_metadata
      0.09 ± 57%      +0.1        0.18 ±127%      +0.0        0.10 ± 20%  perf-profile.children.cycles-pp.f2fs_enable_inode_chksum
      0.39 ± 14%      +0.1        0.47 ± 20%      +0.1        0.46 ± 40%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.13 ± 35%      +0.1        0.22 ±148%      +0.1        0.22 ±118%  perf-profile.children.cycles-pp.blkdev_write_end
      0.08 ±104%      +0.1        0.16 ±143%      -0.0        0.06 ± 57%  perf-profile.children.cycles-pp.rb_erase
      0.01 ±223%      +0.1        0.10 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.elv_rb_del
      0.01 ±223%      +0.1        0.10 ±223%      +0.0        0.01 ±206%  perf-profile.children.cycles-pp.deadline_remove_request
      0.50 ± 18%      +0.1        0.59 ± 27%      +0.0        0.53 ± 11%  perf-profile.children.cycles-pp.rename
      0.03 ±155%      +0.1        0.12 ± 49%      +0.1        0.09 ± 54%  perf-profile.children.cycles-pp.schedule_idle
      0.23 ± 30%      +0.1        0.33 ± 31%      +0.0        0.25 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.46 ± 17%      +0.1        0.56 ± 27%      +0.0        0.51 ± 12%  perf-profile.children.cycles-pp.__x64_sys_rename
      0.04 ±112%      +0.1        0.13 ± 51%      +0.0        0.08 ± 65%  perf-profile.children.cycles-pp.machine__process_mmap2_event
      0.00            +0.1        0.10 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__vma_rb_erase
      0.02 ±141%      +0.1        0.12 ±180%      +0.0        0.04 ± 97%  perf-profile.children.cycles-pp.dd_dispatch_request
      1.45 ± 10%      +0.1        1.55 ± 26%      -0.1        1.31 ± 11%  perf-profile.children.cycles-pp.__invalidate_mapping_pages
      2.18 ±  3%      +0.1        2.28 ± 13%      +0.2        2.42 ± 19%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.47 ±  4%      +0.1        0.57 ±  8%      +0.0        0.48 ±  8%  perf-profile.children.cycles-pp.f2fs_build_segment_manager
      0.15 ± 33%      +0.1        0.26 ± 83%      +0.0        0.15 ± 28%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.05 ±116%      +0.1        0.16 ±210%      +0.0        0.06 ± 96%  perf-profile.children.cycles-pp.update_segment_mtime
      0.10 ± 50%      +0.1        0.21 ±106%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.f2fs_inode_chksum_verify
      0.49 ± 24%      +0.1        0.61 ± 55%      +0.6        1.07 ± 56%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.03 ±101%      +0.1        0.14 ±154%      +0.0        0.06 ± 71%  perf-profile.children.cycles-pp.__dentry_kill
      1.11 ±  9%      +0.1        1.22 ± 18%      +0.3        1.38 ± 20%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.43 ± 18%      +0.1        0.55 ± 28%      +0.1        0.49 ± 11%  perf-profile.children.cycles-pp.do_renameat2
      0.19 ± 42%      +0.1        0.31 ± 66%      +0.0        0.22 ± 25%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.80 ±  9%      +0.1        0.92 ± 18%      +0.0        0.84 ±  7%  perf-profile.children.cycles-pp.__folio_mark_dirty
      1.06 ± 10%      +0.1        1.18 ± 18%      +0.3        1.35 ± 20%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.18 ± 33%      +0.1        0.30 ± 67%      +0.0        0.20 ± 25%  perf-profile.children.cycles-pp.do_mmap
      0.16 ± 38%      +0.1        0.28 ± 72%      +0.0        0.17 ± 28%  perf-profile.children.cycles-pp.mmap_region
      1.29 ±  6%      +0.1        1.42 ±  7%      -0.0        1.29 ±  9%  perf-profile.children.cycles-pp.__close_nocancel
      0.89 ± 30%      +0.1        1.02 ± 17%      -0.1        0.75 ± 10%  perf-profile.children.cycles-pp.f2fs_wait_on_page_writeback
      0.30 ± 36%      +0.1        0.42 ± 16%      +0.0        0.33 ± 15%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.13 ±113%      +0.0        0.02 ±300%  perf-profile.children.cycles-pp.map__process_kallsym_symbol
      0.20 ± 33%      +0.1        0.34 ± 24%      +0.0        0.23 ± 30%  perf-profile.children.cycles-pp.intel_idle
      0.20 ± 51%      +0.1        0.34 ± 83%      +0.1        0.29 ± 78%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.38 ± 99%      +0.1        0.52 ±118%      -0.1        0.26 ± 13%  perf-profile.children.cycles-pp.alloc_inode
      0.38 ± 98%      +0.2        0.54 ±114%      -0.1        0.28 ± 15%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.11 ± 35%      +0.2        0.27 ±150%      +0.0        0.11 ± 25%  perf-profile.children.cycles-pp.invalidate_inode_page
      0.07 ± 41%      +0.2        0.23 ± 90%      +0.0        0.09 ± 40%  perf-profile.children.cycles-pp.__do_munmap
      0.43 ± 72%      +0.2        0.59 ± 43%      -0.0        0.39 ± 37%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.43 ± 72%      +0.2        0.59 ± 43%      -0.0        0.39 ± 37%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.01 ±223%      +0.2        0.18 ±142%      +0.0        0.02 ±300%  perf-profile.children.cycles-pp.s_show
      8.86 ±  3%      +0.2        9.04 ± 20%      -0.6        8.30 ± 13%  perf-profile.children.cycles-pp.handle_level_irq
      1.03 ± 24%      +0.2        1.20 ± 11%      -0.2        0.80 ± 12%  perf-profile.children.cycles-pp.io_schedule
      0.48 ± 66%      +0.2        0.66 ± 37%      -0.0        0.47 ± 31%  perf-profile.children.cycles-pp.machines__deliver_event
      0.54 ± 59%      +0.2        0.72 ± 34%      -0.0        0.54 ± 24%  perf-profile.children.cycles-pp.process_simple
      0.05 ± 84%      +0.2        0.24 ±116%      +0.0        0.07 ±124%  perf-profile.children.cycles-pp.seq_vprintf
      0.00            +0.2        0.18 ±223%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.f2fs_release_page
      0.54 ± 59%      +0.2        0.73 ± 33%      +0.0        0.55 ± 25%  perf-profile.children.cycles-pp.record__finish_output
      0.54 ± 59%      +0.2        0.73 ± 33%      +0.0        0.55 ± 25%  perf-profile.children.cycles-pp.perf_session__process_events
      0.54 ± 59%      +0.2        0.73 ± 33%      +0.0        0.55 ± 25%  perf-profile.children.cycles-pp.cmd_sched
      0.54 ± 59%      +0.2        0.73 ± 33%      +0.0        0.55 ± 25%  perf-profile.children.cycles-pp.cmd_record
      0.50 ± 62%      +0.2        0.69 ± 36%      -0.0        0.49 ± 28%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.55 ± 57%      +0.2        0.74 ± 31%      +0.0        0.56 ± 25%  perf-profile.children.cycles-pp.main
      0.55 ± 57%      +0.2        0.74 ± 31%      +0.0        0.56 ± 25%  perf-profile.children.cycles-pp.run_builtin
      0.55 ± 57%      +0.2        0.74 ± 31%      +0.0        0.56 ± 25%  perf-profile.children.cycles-pp.__libc_start_main
      0.06 ± 89%      +0.2        0.25 ±107%      +0.0        0.10 ± 73%  perf-profile.children.cycles-pp.vsnprintf
      0.05 ± 87%      +0.2        0.24 ±117%      +0.0        0.07 ±124%  perf-profile.children.cycles-pp.seq_printf
      0.28 ± 23%      +0.2        0.48 ± 92%      +0.1        0.38 ± 49%  perf-profile.children.cycles-pp.charge_memcg
      1.03 ± 26%      +0.2        1.22 ± 13%      -0.2        0.78 ± 12%  perf-profile.children.cycles-pp.folio_wait_bit
      0.88 ± 36%      +0.2        1.08 ± 54%      +0.1        0.96 ± 24%  perf-profile.children.cycles-pp.f2fs_new_inode
      0.00            +0.2        0.20 ±123%      +0.0        0.05 ±260%  perf-profile.children.cycles-pp.__dso__load_kallsyms
     10.92 ± 16%      +0.2       11.12 ±  5%      -0.6       10.36 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.2        0.21 ±115%      +0.0        0.05 ±260%  perf-profile.children.cycles-pp.kallsyms__parse
      0.00            +0.2        0.21 ±116%      +0.0        0.05 ±260%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.00            +0.2        0.21 ±116%      +0.0        0.05 ±260%  perf-profile.children.cycles-pp.thread__find_map
      0.00            +0.2        0.21 ±116%      +0.0        0.05 ±260%  perf-profile.children.cycles-pp.map__load
      0.00            +0.2        0.21 ±116%      +0.0        0.05 ±260%  perf-profile.children.cycles-pp.dso__load
      1.03 ± 26%      +0.2        1.24 ± 14%      -0.2        0.80 ± 12%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.16 ±133%      +0.2        0.38 ±188%      -0.1        0.08 ± 65%  perf-profile.children.cycles-pp.scsi_alloc_sgtables
      0.20 ±107%      +0.2        0.42 ±163%      -0.1        0.11 ± 48%  perf-profile.children.cycles-pp.sd_setup_read_write_cmnd
      0.30 ± 84%      +0.2        0.52 ± 14%      -0.2        0.13 ± 38%  perf-profile.children.cycles-pp.f2fs_wait_on_node_pages_writeback
      4.46 ± 13%      +0.2        4.68 ± 12%      +0.1        4.60 ± 10%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.11 ±200%      +0.2        0.34 ±209%      -0.1        0.04 ±105%  perf-profile.children.cycles-pp.__blk_rq_map_sg
      0.62 ± 17%      +0.2        0.86 ± 19%      -0.1        0.56 ± 14%  perf-profile.children.cycles-pp.wake_page_function
      0.34 ± 34%      +0.2        0.58 ±106%      +0.0        0.36 ± 17%  perf-profile.children.cycles-pp.___slab_alloc
      0.22 ± 17%      +0.2        0.46 ±144%      +0.0        0.26 ± 52%  perf-profile.children.cycles-pp.f2fs_update_dirty_page
      1.09 ± 12%      +0.2        1.33 ± 15%      -0.1        1.01 ±  9%  perf-profile.children.cycles-pp.__wake_up_common
      0.02 ±223%      +0.2        0.26 ±141%      +0.0        0.04 ±299%  perf-profile.children.cycles-pp.proc_reg_read
      0.34 ± 34%      +0.2        0.59 ±103%      +0.0        0.37 ± 18%  perf-profile.children.cycles-pp.__slab_alloc
      1.47 ± 15%      +0.2        1.72 ± 21%      -0.0        1.46 ± 16%  perf-profile.children.cycles-pp.native_io_delay
      0.59 ±  8%      +0.2        0.84 ± 27%      +0.0        0.62 ± 12%  perf-profile.children.cycles-pp.rmqueue
      0.12 ± 32%      +0.2        0.37 ±168%      -0.0        0.09 ± 33%  perf-profile.children.cycles-pp.allocate_slab
      2.88 ± 16%      +0.3        3.13 ± 14%      +0.1        2.94 ± 12%  perf-profile.children.cycles-pp.f2fs_create
      1.41 ± 13%      +0.3        1.67 ± 12%      +0.1        1.49 ± 14%  perf-profile.children.cycles-pp.blk_update_request
      1.05 ± 41%      +0.3        1.31 ± 50%      -0.1        0.96 ± 42%  perf-profile.children.cycles-pp.delay_halt_tpause
      1.44 ±  5%      +0.3        1.70 ± 15%      +0.1        1.50 ± 13%  perf-profile.children.cycles-pp.folio_alloc
      0.15 ± 42%      +0.3        0.42 ± 88%      +0.0        0.16 ± 97%  perf-profile.children.cycles-pp.seq_read_iter
      0.01 ±223%      +0.3        0.28 ± 37%      +0.8        0.85 ±  7%  perf-profile.children.cycles-pp.queue_work_on
      0.76 ± 36%      +0.3        1.03 ±123%      -0.0        0.72 ± 38%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      1.92 ± 12%      +0.3        2.20 ± 29%      +0.2        2.10 ± 15%  perf-profile.children.cycles-pp.f2fs_write_data_pages
      0.02 ±223%      +0.3        0.30 ±123%      +0.1        0.07 ±191%  perf-profile.children.cycles-pp.__libc_read
      0.28 ± 28%      +0.3        0.56 ± 84%      +0.0        0.32 ± 19%  perf-profile.children.cycles-pp.path_parentat
      1.10 ± 41%      +0.3        1.39 ± 52%      -0.1        0.99 ± 43%  perf-profile.children.cycles-pp.delay_halt
      0.16 ± 19%      +0.3        0.45 ±148%      +0.1        0.24 ± 64%  perf-profile.children.cycles-pp.__raw_callee_save___native_queued_spin_unlock
      0.29 ± 26%      +0.3        0.58 ± 80%      +0.0        0.34 ± 18%  perf-profile.children.cycles-pp.filename_parentat
      0.36 ± 23%      +0.3        0.65 ± 84%      +0.1        0.42 ± 59%  perf-profile.children.cycles-pp.blk_finish_plug
      0.08 ± 81%      +0.3        0.38 ± 98%      +0.1        0.14 ±101%  perf-profile.children.cycles-pp.seq_read
      0.33 ± 28%      +0.3        0.62 ± 87%      +0.1        0.40 ± 60%  perf-profile.children.cycles-pp.blk_flush_plug
      0.69 ± 18%      +0.3        0.98 ± 14%      -0.0        0.67 ± 24%  perf-profile.children.cycles-pp.folio_wake_bit
      0.16 ± 29%      +0.3        0.46 ±131%      +0.0        0.20 ± 21%  perf-profile.children.cycles-pp.f2fs_alloc_inode
      0.12 ± 56%      +0.3        0.42 ±174%      +0.0        0.14 ± 28%  perf-profile.children.cycles-pp.submit_bio_checks
      0.93 ± 27%      +0.3        1.24 ±103%      -0.0        0.90 ± 31%  perf-profile.children.cycles-pp.__blk_mq_run_hw_queue
      0.92 ± 28%      +0.3        1.23 ±104%      -0.0        0.88 ± 32%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.23 ± 27%      +0.3        0.55 ±110%      +0.1        0.30 ± 14%  perf-profile.children.cycles-pp.new_inode
      0.91 ± 29%      +0.3        1.23 ±104%      -0.0        0.88 ± 32%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      5.55 ±  8%      +0.3        5.87 ± 10%      +0.2        5.71 ± 10%  perf-profile.children.cycles-pp.pagecache_get_page
      0.98 ± 15%      +0.3        1.31 ± 11%      +0.0        0.98 ± 18%  perf-profile.children.cycles-pp.f2fs_write_end_io
      1.71 ±  4%      +0.3        2.05 ± 27%      +0.3        1.98 ± 15%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.52 ± 25%      +0.3        0.86 ± 54%      +0.2        0.70 ± 33%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.58 ± 46%      +0.3        0.93 ±133%      -0.1        0.48 ± 23%  perf-profile.children.cycles-pp.scsi_queue_rq
      5.33 ±  8%      +0.4        5.69 ± 11%      +0.1        5.40 ± 12%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.96 ± 16%      +0.4        1.31 ± 12%      -0.0        0.94 ± 18%  perf-profile.children.cycles-pp.folio_end_writeback
      1.77 ± 23%      +0.4        2.13 ± 24%      +0.1        1.86 ± 26%  perf-profile.children.cycles-pp.__filemap_add_folio
      1.24 ±  9%      +0.4        1.61 ± 35%      +0.3        1.54 ± 22%  perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      2.26 ± 22%      +0.4        2.63 ± 19%      +0.3        2.53 ± 20%  perf-profile.children.cycles-pp.filemap_add_folio
      0.14 ±146%      +0.4        0.51 ± 89%      +0.1        0.26 ± 68%  perf-profile.children.cycles-pp.f2fs_fill_super.cold
      0.67 ± 40%      +0.4        1.05 ±118%      -0.1        0.54 ± 16%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      1.16 ± 37%      +0.4        1.55 ± 48%      -0.1        1.03 ± 37%  perf-profile.children.cycles-pp.mem_serial_in
      0.18 ±103%      +0.4        0.57 ± 47%      +0.1        0.24 ± 98%  perf-profile.children.cycles-pp.drop_caches_sysctl_handler.cold
      1.72 ±  4%      +0.4        2.14 ± 27%      +0.3        2.00 ± 19%  perf-profile.children.cycles-pp.f2fs_write_end
      1.17 ± 14%      +0.4        1.61 ± 16%      +0.0        1.18 ± 19%  perf-profile.children.cycles-pp.proc_sys_call_handler
      1.59 ± 20%      +0.5        2.04 ± 37%      -0.1        1.50 ± 13%  perf-profile.children.cycles-pp.__alloc_pages
      4.12 ±  5%      +0.5        4.58 ± 22%      -0.1        4.04 ± 16%  perf-profile.children.cycles-pp.pit_next_event
      4.12 ±  5%      +0.5        4.59 ± 22%      -0.1        4.05 ± 16%  perf-profile.children.cycles-pp.clockevents_program_event
      3.81 ± 46%      +0.5        4.29 ± 53%      -0.7        3.10 ± 56%  perf-profile.children.cycles-pp.irq_work_run
      3.82 ± 46%      +0.5        4.30 ± 52%      -0.7        3.11 ± 56%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      3.82 ± 46%      +0.5        4.30 ± 52%      -0.7        3.11 ± 56%  perf-profile.children.cycles-pp.sysvec_irq_work
      3.82 ± 46%      +0.5        4.30 ± 52%      -0.7        3.11 ± 56%  perf-profile.children.cycles-pp.__sysvec_irq_work
      3.82 ± 46%      +0.5        4.30 ± 52%      -0.7        3.11 ± 56%  perf-profile.children.cycles-pp.irq_work_single
      3.82 ± 46%      +0.5        4.31 ± 52%      -0.7        3.12 ± 56%  perf-profile.children.cycles-pp.irq_work_run_list
      4.19 ±  2%      +0.5        4.68 ±  7%      +0.1        4.29 ±  4%  perf-profile.children.cycles-pp.update_free_nid_bitmap
      4.95 ±  6%      +0.5        5.44 ± 19%      -0.1        4.88 ± 12%  perf-profile.children.cycles-pp.hrtimer_interrupt
      4.96 ±  6%      +0.5        5.45 ± 19%      -0.1        4.88 ± 12%  perf-profile.children.cycles-pp.timer_interrupt
      0.68 ± 83%      +0.5        1.19 ± 73%      -0.4        0.33 ± 11%  perf-profile.children.cycles-pp.__writepage
      0.42 ± 68%      +0.5        0.93 ±137%      -0.0        0.39 ± 59%  perf-profile.children.cycles-pp.blk_mq_sched_insert_requests
      0.66 ± 87%      +0.5        1.18 ± 73%      -0.3        0.32 ±  9%  perf-profile.children.cycles-pp.__block_write_full_page
      3.78 ± 21%      +0.5        4.30 ± 22%      +0.2        4.03 ± 19%  perf-profile.children.cycles-pp.ksys_write
      1.21 ± 28%      +0.5        1.73 ± 44%      -0.1        1.07 ± 15%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.42 ± 68%      +0.5        0.94 ±135%      -0.0        0.40 ± 60%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.49 ± 47%      +0.5        1.02 ±122%      -0.0        0.47 ± 51%  perf-profile.children.cycles-pp.__blk_mq_delay_run_hw_queue
      0.28 ± 73%      +0.5        0.82 ±108%      -0.1        0.20 ± 18%  perf-profile.children.cycles-pp.submit_bh_wbc
      0.76 ± 72%      +0.6        1.31 ± 64%      -0.3        0.42 ±  8%  perf-profile.children.cycles-pp.blkdev_fsync
      0.75 ± 72%      +0.6        1.31 ± 64%      -0.3        0.42 ±  8%  perf-profile.children.cycles-pp.generic_writepages
      0.75 ± 72%      +0.6        1.31 ± 64%      -0.3        0.42 ±  8%  perf-profile.children.cycles-pp.write_cache_pages
      3.56 ± 14%      +0.6        4.15 ± 29%      -0.2        3.32 ±  8%  perf-profile.children.cycles-pp.file_write_and_wait_range
     78.92            +0.6       79.54            +0.3       79.23        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     78.38            +0.6       79.00            +0.3       78.71        perf-profile.children.cycles-pp.do_syscall_64
      2.19 ± 38%      +0.7        2.84 ± 49%      -0.3        1.93 ± 39%  perf-profile.children.cycles-pp.uart_console_write
      2.19 ± 38%      +0.7        2.84 ± 49%      -0.3        1.93 ± 39%  perf-profile.children.cycles-pp.serial8250_console_putchar
      3.64 ± 20%      +0.7        4.32 ± 21%      +0.4        4.09 ± 19%  perf-profile.children.cycles-pp.write
      2.27 ± 38%      +0.7        2.96 ± 49%      -0.3        2.02 ± 40%  perf-profile.children.cycles-pp.serial8250_console_write
      2.27 ± 38%      +0.7        2.95 ± 49%      -0.2        2.02 ± 40%  perf-profile.children.cycles-pp.wait_for_xmitr
      6.43 ± 12%      +0.7        7.17 ±  5%      +0.4        6.78 ± 10%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.14 ±146%      +0.7        0.88 ± 67%      +0.3        0.45 ± 57%  perf-profile.children.cycles-pp.f2fs_printk
      6.09 ± 11%      +0.7        6.83 ±  6%      +0.2        6.30 ±  7%  perf-profile.children.cycles-pp.copyin
      2.70 ± 23%      +0.8        3.52 ± 37%      -0.2        2.54 ± 12%  perf-profile.children.cycles-pp.do_writepages
      2.71 ± 22%      +0.8        3.52 ± 36%      -0.2        2.54 ± 12%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      4.49 ±  2%      +0.8        5.34 ± 10%      +0.3        4.76 ±  5%  perf-profile.children.cycles-pp.f2fs_build_node_manager
      2.03 ± 31%      +0.9        2.88 ± 52%      -0.1        1.95 ± 34%  perf-profile.children.cycles-pp.cfb_imageblit
      2.04 ± 32%      +0.9        2.91 ± 52%      -0.1        1.98 ± 34%  perf-profile.children.cycles-pp.bit_putcs
      2.05 ± 32%      +0.9        2.92 ± 52%      -0.1        1.99 ± 34%  perf-profile.children.cycles-pp.fbcon_putcs
      2.06 ± 31%      +0.9        2.96 ± 52%      -0.0        2.01 ± 34%  perf-profile.children.cycles-pp.fbcon_redraw
      2.14 ± 30%      +0.9        3.08 ± 51%      -0.0        2.10 ± 33%  perf-profile.children.cycles-pp.con_scroll
      2.14 ± 30%      +0.9        3.08 ± 51%      -0.0        2.10 ± 33%  perf-profile.children.cycles-pp.fbcon_scroll
      2.14 ± 30%      +0.9        3.08 ± 51%      -0.0        2.10 ± 33%  perf-profile.children.cycles-pp.lf
      2.18 ± 31%      +1.0        3.13 ± 52%      -0.1        2.12 ± 32%  perf-profile.children.cycles-pp.vt_console_print
      4.97 ±  2%      +1.0        5.93 ±  9%      +0.3        5.24 ±  5%  perf-profile.children.cycles-pp.f2fs_fill_super
     15.92 ±  6%      +1.1       17.06 ±  4%      +1.4       17.29 ±  6%  perf-profile.children.cycles-pp.f2fs_file_write_iter
     16.56 ±  5%      +1.2       17.80 ±  4%      +1.4       17.93 ±  5%  perf-profile.children.cycles-pp.__libc_pwrite
     16.12 ±  6%      +1.3       17.38 ±  4%      +1.4       17.54 ±  6%  perf-profile.children.cycles-pp.ksys_pwrite64
     15.07 ±  4%      +1.3       16.34 ±  6%      +1.3       16.36 ± 10%  perf-profile.children.cycles-pp.generic_perform_write
      4.76 ± 10%      +1.3        6.04 ± 20%      -0.1        4.68 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.76 ± 10%      +1.3        6.04 ± 20%      -0.1        4.68 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter
     15.22 ±  4%      +1.3       16.53 ±  6%      +1.3       16.55 ± 10%  perf-profile.children.cycles-pp.__generic_file_write_iter
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.__x64_sys_mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.do_mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.path_mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.mount
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.vfs_get_tree
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.legacy_get_tree
      5.11 ±  3%      +1.3        6.44 ±  8%      +0.4        5.50 ±  6%  perf-profile.children.cycles-pp.mount_bdev
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.children.cycles-pp.do_idle
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.children.cycles-pp.start_kernel
      4.87 ±  9%      +1.4        6.24 ± 20%      -0.0        4.86 ± 15%  perf-profile.children.cycles-pp.cpu_startup_entry
      4.13 ± 39%      +1.6        5.74 ± 53%      -0.3        3.79 ± 42%  perf-profile.children.cycles-pp._printk
      4.46 ± 34%      +1.6        6.10 ± 50%      -0.3        4.14 ± 35%  perf-profile.children.cycles-pp.vprintk_emit
      4.46 ± 34%      +1.6        6.10 ± 50%      -0.3        4.14 ± 35%  perf-profile.children.cycles-pp.console_unlock
     19.73 ±  4%      +1.7       21.42 ±  5%      +1.6       21.35 ±  7%  perf-profile.children.cycles-pp.new_sync_write
     19.86 ±  4%      +1.7       21.60 ±  5%      +1.6       21.50 ±  7%  perf-profile.children.cycles-pp.vfs_write
      1.60 ±  9%      -0.4        1.17 ± 20%      -0.2        1.38 ± 20%  perf-profile.self.cycles-pp.__orc_find
      1.16 ± 16%      -0.3        0.90 ± 26%      -0.1        1.08 ± 24%  perf-profile.self.cycles-pp.unwind_next_frame
      2.82 ±  5%      -0.2        2.64 ± 21%      -0.3        2.48 ± 16%  perf-profile.self.cycles-pp.mask_and_ack_8259A
      0.67 ± 21%      -0.2        0.50 ±  6%      -0.1        0.60 ± 16%  perf-profile.self.cycles-pp.step_into
      1.68 ±  9%      -0.1        1.53 ±  8%      +0.0        1.69 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.74 ± 18%      -0.1        0.59 ± 24%      -0.0        0.73 ± 17%  perf-profile.self.cycles-pp.memcpy_erms
      0.26 ± 23%      -0.1        0.12 ± 59%      -0.0        0.25 ± 17%  perf-profile.self.cycles-pp.ahci_handle_port_intr
      0.97 ± 22%      -0.1        0.84 ± 25%      -0.1        0.85 ± 17%  perf-profile.self.cycles-pp.unmask_8259A_irq
      0.28 ±  9%      -0.1        0.17 ± 20%      -0.0        0.27 ± 22%  perf-profile.self.cycles-pp.ahci_handle_port_interrupt
      0.26 ± 34%      -0.1        0.15 ± 64%      -0.0        0.24 ± 38%  perf-profile.self.cycles-pp.__module_address
      1.20 ± 11%      -0.1        1.10 ± 10%      -0.0        1.15 ± 13%  perf-profile.self.cycles-pp.xas_load
      0.95 ±  8%      -0.1        0.85 ± 24%      +0.1        1.00 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.12 ± 41%      -0.1        0.04 ±152%      -0.0        0.12 ± 69%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.16 ± 12%      -0.1        0.07 ± 87%      +0.0        0.17 ± 23%  perf-profile.self.cycles-pp.__list_add_valid
      0.56 ± 23%      -0.1        0.47 ± 20%      -0.0        0.51 ± 15%  perf-profile.self.cycles-pp.orc_find
      0.18 ± 34%      -0.1        0.10 ± 38%      +0.0        0.19 ± 28%  perf-profile.self.cycles-pp.ahci_scr_read
      0.41 ± 19%      -0.1        0.33 ± 23%      -0.0        0.38 ± 19%  perf-profile.self.cycles-pp.aa_may_signal
      1.46 ± 14%      -0.1        1.38 ± 13%      +0.0        1.46 ± 13%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.24 ± 21%      -0.1        0.17 ± 47%      -0.1        0.19 ± 24%  perf-profile.self.cycles-pp.filemap_read
      0.98 ± 22%      -0.1        0.90 ± 12%      +0.0        1.00 ± 12%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.31 ± 22%      -0.1        0.24 ± 19%      -0.0        0.30 ± 15%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.37 ± 16%      -0.1        0.30 ± 44%      -0.0        0.33 ± 23%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.76 ± 17%      -0.1        0.69 ± 14%      -0.0        0.73 ± 20%  perf-profile.self.cycles-pp.__entry_text_start
      0.14 ± 25%      -0.1        0.07 ± 45%      -0.0        0.11 ± 22%  perf-profile.self.cycles-pp.try_to_wake_up
      0.56 ± 17%      -0.1        0.49 ± 29%      -0.1        0.46 ± 24%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.08 ± 67%      -0.1        0.02 ±223%      -0.0        0.06 ± 84%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.14 ± 60%      -0.1        0.08 ± 47%      +0.0        0.16 ± 28%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.66 ± 23%      -0.1        0.59 ± 13%      -0.0        0.62 ± 14%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ± 34%      -0.1        0.07 ± 77%      -0.1        0.08 ± 62%  perf-profile.self.cycles-pp.mntput_no_expire
      0.10 ± 49%      -0.1        0.03 ±103%      -0.0        0.09 ± 24%  perf-profile.self.cycles-pp.f2fs_wait_on_page_writeback
      0.10 ± 44%      -0.1        0.03 ±101%      -0.0        0.06 ± 57%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.29 ± 16%      -0.1        0.22 ± 18%      -0.0        0.24 ± 17%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.47 ± 21%      -0.1        0.41 ± 32%      -0.1        0.40 ± 24%  perf-profile.self.cycles-pp.strncpy_from_user
      0.23 ± 45%      -0.1        0.17 ± 41%      -0.1        0.17 ± 34%  perf-profile.self.cycles-pp.security_inode_permission
      0.18 ± 36%      -0.1        0.12 ± 52%      -0.0        0.15 ± 23%  perf-profile.self.cycles-pp.dput
      0.21 ± 25%      -0.1        0.15 ± 57%      -0.1        0.14 ± 21%  perf-profile.self.cycles-pp.set_root
      0.16 ± 31%      -0.1        0.10 ± 50%      -0.0        0.15 ± 29%  perf-profile.self.cycles-pp.do_dentry_open
      0.12 ± 24%      -0.1        0.06 ± 95%      -0.0        0.09 ± 58%  perf-profile.self.cycles-pp.security_file_alloc
      0.41 ± 14%      -0.1        0.36 ± 17%      -0.0        0.38 ± 18%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.27 ± 24%      -0.1        0.22 ± 27%      +0.0        0.28 ± 16%  perf-profile.self.cycles-pp.__schedule
      0.08 ± 51%      -0.1        0.03 ±100%      -0.0        0.04 ± 85%  perf-profile.self.cycles-pp.__put_user_nocheck_8
      0.06 ± 52%      -0.1        0.01 ±223%      -0.0        0.03 ±105%  perf-profile.self.cycles-pp.strcasecmp@plt
      0.23 ± 30%      -0.0        0.18 ± 20%      +0.0        0.23 ± 21%  perf-profile.self.cycles-pp.__alloc_pages
      0.26 ± 22%      -0.0        0.21 ± 25%      -0.0        0.26 ± 33%  perf-profile.self.cycles-pp.folio_mapping
      0.11 ± 42%      -0.0        0.06 ± 76%      +0.0        0.11 ± 39%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.06 ± 74%      -0.0        0.02 ±223%      -0.0        0.06 ± 56%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.15 ± 24%      -0.0        0.10 ± 58%      -0.0        0.14 ± 21%  perf-profile.self.cycles-pp.__might_fault
      0.16 ± 21%      -0.0        0.11 ± 52%      +0.0        0.17 ± 21%  perf-profile.self.cycles-pp.__slab_free
      0.09 ± 59%      -0.0        0.04 ±103%      -0.0        0.06 ± 62%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.07 ± 59%      -0.0        0.02 ±141%      -0.1        0.01 ±200%  perf-profile.self.cycles-pp.radix_tree_insert
      0.16 ± 18%      -0.0        0.11 ± 32%      -0.1        0.11 ± 19%  perf-profile.self.cycles-pp.xa_load
      0.25 ± 34%      -0.0        0.20 ± 28%      +0.0        0.27 ± 21%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
      0.15 ± 35%      -0.0        0.11 ± 24%      -0.0        0.13 ± 55%  perf-profile.self.cycles-pp.filename_lookup
      0.08 ± 52%      -0.0        0.04 ±104%      +0.0        0.11 ± 56%  perf-profile.self.cycles-pp.atime_needs_update
      0.06 ± 87%      -0.0        0.02 ±144%      -0.0        0.03 ±103%  perf-profile.self.cycles-pp.__kernel_text_address
      0.17 ± 27%      -0.0        0.12 ± 37%      +0.0        0.19 ± 26%  perf-profile.self.cycles-pp.native_sched_clock
      0.10 ± 39%      -0.0        0.06 ± 86%      -0.0        0.06 ± 53%  perf-profile.self.cycles-pp.task_work_run
      0.09 ± 67%      -0.0        0.05 ±109%      -0.0        0.06 ± 70%  perf-profile.self.cycles-pp.alloc_pages
      0.09 ± 48%      -0.0        0.05 ±124%      -0.0        0.09 ± 54%  perf-profile.self.cycles-pp.common_file_perm
      0.10 ± 48%      -0.0        0.06 ± 73%      +0.0        0.12 ± 30%  perf-profile.self.cycles-pp.path_init
      0.04 ±104%      -0.0        0.00            -0.0        0.02 ±159%  perf-profile.self.cycles-pp.blk_mq_dispatch_rq_list
      0.08 ± 96%      -0.0        0.04 ± 72%      -0.0        0.07 ± 68%  perf-profile.self.cycles-pp.update_rq_clock
      0.04 ±106%      -0.0        0.00            -0.0        0.02 ±134%  perf-profile.self.cycles-pp.invalidate_inode_page
      0.17 ± 21%      -0.0        0.13 ± 30%      -0.0        0.14 ± 27%  perf-profile.self.cycles-pp.pagecache_get_page
      0.10 ± 26%      -0.0        0.07 ±  7%      -0.0        0.10 ± 40%  perf-profile.self.cycles-pp.exc_page_fault
      0.16 ± 29%      -0.0        0.12 ± 44%      -0.0        0.12 ± 20%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.11 ± 41%      -0.0        0.08 ± 52%      -0.0        0.08 ± 39%  perf-profile.self.cycles-pp.__ctype_b_loc@plt
      0.12 ± 31%      -0.0        0.08 ± 56%      -0.0        0.08 ± 47%  perf-profile.self.cycles-pp.f2fs_file_write_iter
      0.06 ± 75%      -0.0        0.02 ±142%      -0.0        0.04 ± 84%  perf-profile.self.cycles-pp.f2fs_submit_page_write
      0.05 ± 51%      -0.0        0.02 ±141%      -0.0        0.04 ±116%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.04 ±102%      -0.0        0.00            -0.0        0.04 ±116%  perf-profile.self.cycles-pp.__native_queued_spin_unlock
      0.05 ±127%      -0.0        0.02 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.04 ±168%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_getxattr
      0.04 ± 71%      -0.0        0.00            -0.0        0.02 ±154%  perf-profile.self.cycles-pp.unaccount_page_cache_page
      0.04 ±168%      -0.0        0.00            -0.0        0.02 ±169%  perf-profile.self.cycles-pp.folio_unlock
      0.22 ± 36%      -0.0        0.18 ± 47%      -0.0        0.22 ± 22%  perf-profile.self.cycles-pp.stack_access_ok
      0.13 ± 36%      -0.0        0.10 ± 71%      -0.0        0.09 ± 37%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.16 ± 29%      -0.0        0.12 ± 28%      -0.0        0.15 ± 34%  perf-profile.self.cycles-pp.strchr@plt
      0.14 ± 34%      -0.0        0.11 ± 50%      -0.0        0.14 ± 23%  perf-profile.self.cycles-pp.__fxstat64
      0.27 ± 30%      -0.0        0.24 ± 30%      +0.0        0.32 ± 10%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.11 ± 60%      -0.0        0.08 ± 79%      -0.0        0.10 ± 31%  perf-profile.self.cycles-pp.lockref_put_return
      0.04 ±115%      -0.0        0.01 ±223%      -0.0        0.04 ± 90%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.24 ± 12%      -0.0        0.20 ± 29%      +0.0        0.24 ± 17%  perf-profile.self.cycles-pp.read_node_page
      0.08 ± 29%      -0.0        0.04 ± 71%      -0.0        0.05 ± 90%  perf-profile.self.cycles-pp.terminate_walk
      0.14 ±  9%      -0.0        0.11 ± 49%      -0.0        0.13 ± 30%  perf-profile.self.cycles-pp.cp_new_stat
      0.06 ± 82%      -0.0        0.03 ±155%      -0.0        0.05 ± 53%  perf-profile.self.cycles-pp.nd_jump_root
      0.35 ± 14%      -0.0        0.32 ± 23%      +0.0        0.36 ± 15%  perf-profile.self.cycles-pp.generic_permission
      0.08 ± 16%      -0.0        0.05 ±102%      -0.0        0.05 ± 58%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.04 ± 80%      -0.0        0.01 ±223%      -0.0        0.02 ±154%  perf-profile.self.cycles-pp.allocate_slab
      0.03 ±100%      -0.0        0.00            -0.0        0.03 ±123%  perf-profile.self.cycles-pp.__is_cp_guaranteed
      0.36 ± 20%      -0.0        0.34 ± 15%      -0.1        0.29 ± 22%  perf-profile.self.cycles-pp.find_lock_entries
      0.44 ± 18%      -0.0        0.41 ± 20%      -0.0        0.43 ± 26%  perf-profile.self.cycles-pp.inode_permission
      0.04 ±110%      -0.0        0.01 ±223%      -0.0        0.04 ±107%  perf-profile.self.cycles-pp.core_kernel_text
      0.04 ± 72%      -0.0        0.01 ±223%      -0.0        0.02 ±154%  perf-profile.self.cycles-pp.set_next_entity
      0.04 ± 82%      -0.0        0.01 ±223%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.from_kuid_munged
      0.03 ±161%      -0.0        0.00            +0.0        0.05 ± 75%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.07 ± 76%      -0.0        0.04 ±107%      +0.0        0.08 ± 22%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.14 ± 13%      -0.0        0.12 ± 30%      -0.0        0.11 ± 47%  perf-profile.self.cycles-pp.__switch_to_asm
      0.10 ± 39%      -0.0        0.07 ± 91%      +0.0        0.12 ± 42%  perf-profile.self.cycles-pp.alloc_fd
      0.07 ± 76%      -0.0        0.04 ± 73%      -0.0        0.05 ± 88%  perf-profile.self.cycles-pp.strlen@plt
      0.05 ± 90%      -0.0        0.02 ±144%      -0.0        0.02 ±200%  perf-profile.self.cycles-pp.__block_write_full_page
      0.04 ±106%      -0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_file_flush
      0.07 ± 25%      -0.0        0.04 ±110%      -0.0        0.06 ± 39%  perf-profile.self.cycles-pp.alloc_empty_file
      0.07 ± 55%      -0.0        0.04 ± 72%      -0.0        0.07 ± 71%  perf-profile.self.cycles-pp.enqueue_entity
      0.14 ± 51%      -0.0        0.12 ± 30%      -0.0        0.14 ± 21%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.04 ±107%      -0.0        0.01 ±223%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.04 ±101%      -0.0        0.01 ±223%      -0.0        0.02 ±158%  perf-profile.self.cycles-pp.sbitmap_get
      0.03 ±143%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.03 ±147%      -0.0        0.00            -0.0        0.02 ±153%  perf-profile.self.cycles-pp.__check_heap_object
      0.04 ±106%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.handle_mm_fault
      0.08 ± 23%      -0.0        0.05 ± 84%      -0.0        0.06 ± 55%  perf-profile.self.cycles-pp.get_task_policy
      0.08 ± 54%      -0.0        0.06 ± 51%      +0.0        0.12 ± 24%  perf-profile.self.cycles-pp.update_load_avg
      0.16 ± 16%      -0.0        0.13 ± 46%      -0.0        0.15 ± 22%  perf-profile.self.cycles-pp.f2fs_update_dirty_page
      0.08 ± 54%      -0.0        0.05 ± 91%      +0.0        0.09 ± 32%  perf-profile.self.cycles-pp.__x64_sys_kill
      0.02 ±152%      -0.0        0.00            +0.0        0.04 ±111%  perf-profile.self.cycles-pp.f2fs_mark_inode_dirty_sync
      0.04 ± 80%      -0.0        0.02 ±142%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.update_min_vruntime
      0.06 ± 53%      -0.0        0.04 ±101%      -0.0        0.05 ± 54%  perf-profile.self.cycles-pp.kill_something_info
      0.08 ± 49%      -0.0        0.06 ±103%      -0.0        0.08 ± 72%  perf-profile.self.cycles-pp.kernel_text_address
      0.05 ±102%      -0.0        0.02 ±145%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.verify_dirent_name
      0.05 ± 74%      -0.0        0.03 ±147%      -0.0        0.04 ±103%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.20 ± 20%      -0.0        0.18 ± 38%      +0.0        0.22 ± 32%  perf-profile.self.cycles-pp.malloc
      0.03 ±102%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__legitimize_path
      0.07 ± 63%      -0.0        0.04 ± 83%      -0.0        0.05 ± 63%  perf-profile.self.cycles-pp.down_write
      0.05 ± 76%      -0.0        0.02 ±141%      -0.0        0.04 ±103%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.09 ± 57%      -0.0        0.07 ± 59%      +0.0        0.10 ± 25%  perf-profile.self.cycles-pp.f2fs_enable_inode_chksum
      0.10 ± 25%      -0.0        0.08 ± 47%      +0.0        0.11 ± 20%  perf-profile.self.cycles-pp.inode_to_bdi
      0.10 ± 37%      -0.0        0.08 ± 72%      +0.0        0.15 ± 40%  perf-profile.self.cycles-pp.update_curr
      0.18 ± 20%      -0.0        0.15 ± 20%      +0.0        0.19 ± 16%  perf-profile.self.cycles-pp.f2fs_hash_filename
      0.17 ± 56%      -0.0        0.15 ± 75%      +0.0        0.20 ± 15%  perf-profile.self.cycles-pp.__unwind_start
      0.10 ± 51%      -0.0        0.08 ± 55%      -0.0        0.07 ± 54%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.28 ± 15%      -0.0        0.26 ± 38%      -0.0        0.23 ± 28%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__ata_scsi_queuecmd
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.expand_files
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.raise_softirq
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__blk_mq_get_driver_tag
      0.03 ±161%      -0.0        0.01 ±223%      -0.0        0.01 ±206%  perf-profile.self.cycles-pp.f2fs_write_cache_pages
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__kmalloc_node
      0.05 ± 80%      -0.0        0.03 ±108%      -0.0        0.04 ±104%  perf-profile.self.cycles-pp.error_entry
      0.03 ±105%      -0.0        0.01 ±223%      -0.0        0.03 ±131%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.21 ± 28%      -0.0        0.18 ± 37%      +0.0        0.22 ± 25%  perf-profile.self.cycles-pp.memchr
      0.10 ± 19%      -0.0        0.08 ± 55%      -0.0        0.06 ± 56%  perf-profile.self.cycles-pp.path_lookupat
      0.54 ± 22%      -0.0        0.52 ± 14%      +0.1        0.61 ± 17%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.03 ±144%      -0.0        0.01 ±223%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.f2fs_invalidate_page
      0.06 ± 60%      -0.0        0.04 ±107%      +0.0        0.11 ± 44%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.bsearch
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.blk_mq_run_hw_queue
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.f2fs_get_node_page
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.find_vpid
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.ksoftirqd_running
      0.02 ±144%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.____machine__findnew_thread
      0.02 ±144%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.set_next_buddy
      0.02 ±144%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__block_write_begin_int
      0.07 ± 57%      -0.0        0.05 ± 74%      -0.0        0.06 ± 36%  perf-profile.self.cycles-pp.f2fs_reserve_new_blocks
      0.09 ± 30%      -0.0        0.07 ± 55%      -0.0        0.08 ± 53%  perf-profile.self.cycles-pp.security_inode_getattr
      0.44 ± 20%      -0.0        0.42 ± 16%      -0.0        0.43 ± 23%  perf-profile.self.cycles-pp.do_syscall_64
      0.10 ± 14%      -0.0        0.08 ± 74%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ± 65%      -0.0        0.04 ± 73%      -0.0        0.02 ±124%  perf-profile.self.cycles-pp.schedule
      0.07 ± 21%      -0.0        0.05 ± 76%      -0.0        0.07 ± 44%  perf-profile.self.cycles-pp.__lookup_mnt
      0.13 ± 45%      -0.0        0.11 ± 24%      +0.0        0.13 ± 26%  perf-profile.self.cycles-pp.perf_output_copy
      0.10 ± 30%      -0.0        0.08 ± 89%      +0.0        0.11 ± 34%  perf-profile.self.cycles-pp.iterate_dir
      0.06 ± 78%      -0.0        0.04 ±118%      -0.0        0.02 ±129%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.reweight_entity
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.self.cycles-pp.igb_rd32
      0.02 ±142%      -0.0        0.00            -0.0        0.01 ±200%  perf-profile.self.cycles-pp.handle_level_irq
      0.03 ±145%      -0.0        0.02 ±223%      -0.0        0.03 ±133%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.07 ± 48%      -0.0        0.05 ±103%      +0.0        0.07 ± 54%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.04 ±102%      -0.0        0.02 ±144%      -0.0        0.02 ±159%  perf-profile.self.cycles-pp.f2fs_add_inline_entry
      0.11 ± 24%      -0.0        0.09 ± 34%      +0.0        0.11 ± 26%  perf-profile.self.cycles-pp.get_perf_callchain
      0.20 ± 34%      -0.0        0.18 ± 29%      -0.1        0.12 ± 24%  perf-profile.self.cycles-pp.mod_objcg_state
      0.13 ± 49%      -0.0        0.11 ± 38%      -0.1        0.07 ± 43%  perf-profile.self.cycles-pp.strtoll
      0.09 ± 48%      -0.0        0.08 ± 82%      +0.0        0.10 ± 32%  perf-profile.self.cycles-pp.__x64_sys_getdents64
      0.02 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.02 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.folio_memcg_unlock
      0.02 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.copyout
      0.02 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.folio_wake_bit
      0.02 ±141%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.wake_up_q
      0.02 ±141%      -0.0        0.00            -0.0        0.01 ±203%  perf-profile.self.cycles-pp.__submit_merged_write_cond
      0.02 ±223%      -0.0        0.00            +0.0        0.02 ±157%  perf-profile.self.cycles-pp.__mnt_want_write
      0.04 ± 80%      -0.0        0.03 ±155%      +0.0        0.06 ± 58%  perf-profile.self.cycles-pp.workingset_activation
      0.07 ± 50%      -0.0        0.06 ± 74%      +0.0        0.10 ± 43%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.32 ± 19%      -0.0        0.31 ± 25%      -0.0        0.29 ± 28%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.21 ± 23%      -0.0        0.20 ± 25%      +0.0        0.24 ± 17%  perf-profile.self.cycles-pp.__cond_resched
      0.04 ±110%      -0.0        0.03 ±101%      -0.0        0.02 ±130%  perf-profile.self.cycles-pp.uncharge_folio
      0.04 ±170%      -0.0        0.02 ±142%      -0.0        0.02 ±125%  perf-profile.self.cycles-pp.__dquot_initialize
      0.05 ± 76%      -0.0        0.04 ±115%      +0.0        0.06 ± 74%  perf-profile.self.cycles-pp.load_new_mm_cr3
      0.04 ±101%      -0.0        0.02 ±141%      -0.0        0.02 ±154%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.04 ± 80%      -0.0        0.03 ±150%      +0.0        0.06 ± 72%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.04 ±156%      -0.0        0.02 ±143%      +0.0        0.08 ±104%  perf-profile.self.cycles-pp.filemap_dirty_folio
      0.03 ±106%      -0.0        0.02 ±142%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.putname
      0.02 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.hrtimer_interrupt
      0.07 ± 48%      -0.0        0.05 ± 46%      +0.0        0.09 ± 60%  perf-profile.self.cycles-pp.__switch_to
      0.06 ± 60%      -0.0        0.04 ±117%      -0.0        0.03 ±128%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.06 ± 88%      -0.0        0.04 ±108%      +0.0        0.07 ± 55%  perf-profile.self.cycles-pp.aa_get_task_label
      0.26 ± 23%      -0.0        0.25 ± 31%      +0.0        0.30 ± 20%  perf-profile.self.cycles-pp.kill
      0.14 ± 22%      -0.0        0.13 ± 30%      +0.0        0.15 ± 45%  perf-profile.self.cycles-pp.call_rcu
      0.10 ± 29%      -0.0        0.08 ± 47%      +0.0        0.10 ± 42%  perf-profile.self.cycles-pp.xas_find_conflict
      0.06 ± 76%      -0.0        0.05 ± 83%      +0.0        0.08 ± 42%  perf-profile.self.cycles-pp.f2fs_update_inode
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.closedir@plt
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.do_wp_page
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.file_free_rcu
      0.02 ±146%      -0.0        0.01 ±223%      +0.0        0.03 ±129%  perf-profile.self.cycles-pp.f2fs_update_iostat
      0.02 ±146%      -0.0        0.01 ±223%      +0.0        0.04 ± 84%  perf-profile.self.cycles-pp.security_file_free
      0.03 ±101%      -0.0        0.02 ±144%      -0.0        0.02 ±173%  perf-profile.self.cycles-pp.node_page_state
      0.03 ±111%      -0.0        0.02 ±144%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.rcu_do_batch
      0.06 ± 52%      -0.0        0.04 ±109%      -0.0        0.04 ± 83%  perf-profile.self.cycles-pp.apparmor_file_open
      0.10 ± 53%      -0.0        0.09 ± 57%      -0.0        0.09 ± 42%  perf-profile.self.cycles-pp.f2fs_inode_dirtied
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.swake_up_one
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.kernelmode_fixup_or_oops
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__module_text_address
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.blk_mq_rq_ctx_init
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.blk_attempt_plug_merge
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp._IO_file_write
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.PyType_GenericAlloc
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__acct_update_integrals
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.d_flags_for_inode
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.irqentry_exit
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.lru_deactivate_file_fn
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.se_is_idle
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__mbrtowc
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.dget_parent
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp.fscrypt_fname_free_buffer
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.strnlen_user
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.blk_finish_plug
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__remove_mapping
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.rcu_gp_cleanup
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.place_entity
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.cr4_update_irqsoff
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±201%  perf-profile.self.cycles-pp.mutex_lock
      0.02 ±141%      -0.0        0.01 ±223%      +0.0        0.02 ±160%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±154%  perf-profile.self.cycles-pp.kick_process
      0.03 ±141%      -0.0        0.02 ±141%      +0.0        0.07 ± 65%  perf-profile.self.cycles-pp.__perf_event_overflow
      0.16 ± 50%      -0.0        0.14 ± 28%      -0.0        0.11 ± 43%  perf-profile.self.cycles-pp.generic_fillattr
      0.22 ± 17%      -0.0        0.21 ± 13%      -0.0        0.22 ± 22%  perf-profile.self.cycles-pp.xas_store
      0.30 ± 28%      -0.0        0.29 ± 31%      -0.0        0.29 ± 22%  perf-profile.self.cycles-pp.generic_perform_write
      0.06 ± 51%      -0.0        0.05 ± 76%      +0.0        0.06 ± 49%  perf-profile.self.cycles-pp.strlen
      0.42 ± 24%      -0.0        0.41 ± 23%      +0.1        0.49 ± 10%  perf-profile.self.cycles-pp.release_pages
      0.10 ± 54%      -0.0        0.09 ± 68%      -0.0        0.07 ± 54%  perf-profile.self.cycles-pp.common_perm
      0.04 ±107%      -0.0        0.03 ±143%      -0.0        0.03 ±106%  perf-profile.self.cycles-pp.perf_tp_event_match
      0.03 ±144%      -0.0        0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.f2fs_update_extent_tree_range
      0.05 ± 50%      -0.0        0.04 ±107%      +0.0        0.09 ± 27%  perf-profile.self.cycles-pp.finish_task_switch
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.blk_complete_reqs
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.smpboot_thread_fn
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.mark_buffer_dirty
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.f2fs_sync_inode_meta
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.page_add_file_rmap
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__x64_sys_openat
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.ata_qc_new_init
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.copy_from_kernel_nofault
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.elv_rb_del
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.sched_slice
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.vmacache_find
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__delete_from_page_cache
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.note_gp_changes
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.rcu_gp_init
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.f2fs_get_node_info
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.closedir
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.02 ±201%  perf-profile.self.cycles-pp.f2fs_write_end_io
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.do_writepages
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±203%  perf-profile.self.cycles-pp.put_cpu_partial
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±216%  perf-profile.self.cycles-pp.__f2fs_find_entry
      0.02 ±144%      -0.0        0.01 ±223%      +0.0        0.04 ± 85%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.03 ±106%      -0.0        0.02 ±223%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.legitimize_links
      0.06 ± 77%      -0.0        0.04 ± 75%      +0.0        0.06 ± 57%  perf-profile.self.cycles-pp.f2fs_write_single_data_page
      0.04 ±104%      -0.0        0.03 ±100%      +0.0        0.07 ± 55%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.32 ± 35%      -0.0        0.31 ± 11%      -0.1        0.26 ± 26%  perf-profile.self.cycles-pp.f2fs_truncate_data_blocks_range
      0.34 ±105%      -0.0        0.34 ± 80%      +0.1        0.42 ± 48%  perf-profile.self.cycles-pp.poll_idle
      0.03 ±103%      -0.0        0.02 ±141%      -0.0        0.02 ±155%  perf-profile.self.cycles-pp.perf_swevent_overflow
      0.03 ±102%      -0.0        0.02 ±144%      +0.0        0.04 ±130%  perf-profile.self.cycles-pp.__count_memcg_events
      0.03 ±103%      -0.0        0.02 ±223%      +0.0        0.04 ±109%  perf-profile.self.cycles-pp.new_sync_read
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_core
      0.02 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__d_instantiate
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.rcu_segcblist_pend_cbs
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.mod_delayed_work_on
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.user_statfs
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.submit_bh_wbc
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__xa_clear_mark
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.bit_waitqueue
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.rw_verify_area
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.handle_irq_event_percpu
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.kblockd_mod_delayed_work_on
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__statfs
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__dd_dispatch_request
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp._IO_getline
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.f2fs_update_parent_metadata
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__handle_irq_event_percpu
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.write
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.folio_end_writeback
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__blk_mq_delay_run_hw_queue
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.ktime_get_mono_fast_ns
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__srcu_read_unlock
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.PyType_Ready
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_alloc_nid
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.self.cycles-pp.task_work_add
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.self.cycles-pp.ata_qc_complete
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.put_pid
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.make_kgid
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.locks_remove_file
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±300%  perf-profile.self.cycles-pp.blk_mq_complete_request_remote
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.__x64_sys_close
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.tag_pages_for_writeback
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±203%  perf-profile.self.cycles-pp.rcu_accelerate_cbs
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±209%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±200%  perf-profile.self.cycles-pp.__write_node_page
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±153%  perf-profile.self.cycles-pp.__mem_cgroup_uncharge_list
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±154%  perf-profile.self.cycles-pp.clear_buddies
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±154%  perf-profile.self.cycles-pp.asm_common_interrupt
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±155%  perf-profile.self.cycles-pp.folio_add_lru
      0.01 ±223%      -0.0        0.00            +0.0        0.03 ±126%  perf-profile.self.cycles-pp.menu_select
      0.10 ± 51%      -0.0        0.09 ± 26%      -0.0        0.09 ± 37%  perf-profile.self.cycles-pp.__ctype_b_loc
      0.04 ±104%      -0.0        0.03 ±148%      +0.0        0.06 ± 53%  perf-profile.self.cycles-pp.__get_meta_page
      0.18 ± 40%      -0.0        0.17 ± 28%      +0.0        0.21 ± 21%  perf-profile.self.cycles-pp.__fget_light
      0.07 ±102%      -0.0        0.06 ± 73%      -0.0        0.05 ± 54%  perf-profile.self.cycles-pp.rb_erase
      0.07 ± 51%      -0.0        0.06 ± 57%      +0.0        0.07 ± 53%  perf-profile.self.cycles-pp.errseq_sample
      0.07 ± 55%      -0.0        0.06 ± 79%      -0.0        0.03 ±129%  perf-profile.self.cycles-pp.common_perm_cond
      0.06 ± 53%      -0.0        0.06 ± 57%      -0.0        0.05 ± 77%  perf-profile.self.cycles-pp.PageHeadHuge
      0.04 ± 72%      -0.0        0.03 ±100%      -0.0        0.04 ±107%  perf-profile.self.cycles-pp.update_cfs_group
      0.12 ± 15%      -0.0        0.11 ± 33%      +0.0        0.12 ± 22%  perf-profile.self.cycles-pp._IO_getline_info
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.cmp_ex_search
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp._IO_fwrite
      0.02 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±123%  perf-profile.self.cycles-pp.insert_inode_locked
      0.02 ±223%      -0.0        0.01 ±223%      +0.0        0.04 ± 85%  perf-profile.self.cycles-pp.perf_callchain
      0.03 ±102%      -0.0        0.02 ±141%      +0.0        0.04 ± 85%  perf-profile.self.cycles-pp.__close
      0.04 ±101%      -0.0        0.03 ±146%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.PyObject_GetAttr
      0.04 ±104%      -0.0        0.03 ±100%      -0.0        0.02 ±200%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.02 ±152%      -0.0        0.02 ±144%      -0.0        0.02 ±155%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.12 ± 36%      -0.0        0.12 ± 64%      +0.0        0.13 ± 29%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.09 ± 25%      -0.0        0.08 ± 50%      +0.0        0.10 ± 25%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ± 64%      -0.0        0.10 ± 50%      +0.0        0.14 ± 37%  perf-profile.self.cycles-pp.do_filp_open
      0.03 ±102%      -0.0        0.02 ±149%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.blk_flush_plug
      0.02 ±143%      -0.0        0.02 ±142%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.perf_callchain_user
      0.02 ±149%      -0.0        0.02 ±142%      +0.0        0.03 ±126%  perf-profile.self.cycles-pp.kill_pid_info
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±124%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.02 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.f2fs_unlink
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.ksys_pread64
      0.05 ±100%      -0.0        0.05 ±111%      -0.0        0.05 ± 87%  perf-profile.self.cycles-pp.rb_insert_color
      0.06 ± 77%      -0.0        0.06 ± 50%      +0.0        0.06 ± 59%  perf-profile.self.cycles-pp.__libc_pread
      0.06 ± 52%      -0.0        0.06 ± 85%      +0.0        0.06 ± 59%  perf-profile.self.cycles-pp.f2fs_get_dnode_of_data
      0.07 ± 50%      -0.0        0.07 ± 50%      +0.0        0.08 ± 69%  perf-profile.self.cycles-pp.__invalidate_mapping_pages
      0.03 ±100%      -0.0        0.02 ±223%      -0.0        0.01 ±203%  perf-profile.self.cycles-pp.__blk_mq_do_dispatch_sched
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.complete_walk
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.audit_signal_info
      0.02 ±142%      -0.0        0.02 ±223%      +0.0        0.04 ±107%  perf-profile.self.cycles-pp.f2fs_new_inode
      0.02 ±146%      -0.0        0.02 ±142%      +0.0        0.05 ± 71%  perf-profile.self.cycles-pp.filp_close
      0.04 ± 72%      -0.0        0.04 ±103%      +0.0        0.07 ± 53%  perf-profile.self.cycles-pp.scsi_queue_rq
      0.02 ±223%      -0.0        0.01 ±223%      +0.0        0.04 ±109%  perf-profile.self.cycles-pp.update_segment_mtime
      0.15 ± 48%      -0.0        0.14 ± 19%      +0.0        0.19 ± 20%  perf-profile.self.cycles-pp.___slab_alloc
      0.16 ± 57%      -0.0        0.16 ± 50%      -0.0        0.13 ± 32%  perf-profile.self.cycles-pp.node_dirty_ok
      0.13 ± 22%      -0.0        0.13 ± 38%      -0.0        0.11 ± 58%  perf-profile.self.cycles-pp.try_charge_memcg
      0.02 ±152%      -0.0        0.02 ±149%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__x64_sys_newfstat
      0.04 ± 72%      -0.0        0.04 ±104%      -0.0        0.03 ±106%  perf-profile.self.cycles-pp.__alloc_file
      0.03 ±100%      -0.0        0.03 ±161%      -0.0        0.02 ±129%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.02 ±152%      -0.0        0.02 ±149%      -0.0        0.02 ±155%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.04 ±101%      -0.0        0.03 ±106%      +0.0        0.05 ± 52%  perf-profile.self.cycles-pp.get_callchain_entry
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.pagevec_remove_exceptionals
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.snprintf
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp._find_first_bit
      0.01 ±223%      -0.0        0.01 ±223%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.__get_segment_type
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.submit_bio_noacct
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.sync_regs
      0.02 ±141%      -0.0        0.02 ±223%      +0.0        0.03 ±107%  perf-profile.self.cycles-pp.__blk_rq_map_sg
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±125%  perf-profile.self.cycles-pp.__d_lookup
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±122%  perf-profile.self.cycles-pp.f2fs_file_open
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.05 ± 73%  perf-profile.self.cycles-pp.timestamp_truncate
      0.08 ± 34%      -0.0        0.08 ± 47%      +0.0        0.08 ± 29%  perf-profile.self.cycles-pp.build_sit_entries
      0.07 ± 59%      -0.0        0.07 ± 60%      +0.0        0.09 ± 30%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.13 ± 47%      -0.0        0.13 ± 77%      +0.0        0.17 ± 34%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.08 ± 59%      +0.0        0.08 ± 55%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.f2fs_set_data_page_dirty
      0.18 ± 43%      +0.0        0.18 ± 31%      -0.0        0.16 ± 30%  perf-profile.self.cycles-pp.__xstat64
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__add_ino_entry
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.PyDict_SetItem
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__is_insn_slot_addr
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__common_interrupt
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.block_invalidatepage
      0.03 ±142%      +0.0        0.03 ±101%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp._copy_to_user
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.xas_nomem
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.switch_fpu_return
      0.06 ± 63%      +0.0        0.06 ±104%      -0.0        0.05 ± 54%  perf-profile.self.cycles-pp.f2fs_convert_inline_inode
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.scsi_init_command
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.list_lru_add
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.lru_add_drain
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.unlink
      0.04 ±107%      +0.0        0.04 ±107%      -0.0        0.04 ±104%  perf-profile.self.cycles-pp.zap_pte_range
      0.04 ±109%      +0.0        0.04 ±100%      +0.0        0.04 ± 83%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.get_partial_node
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.fput_many
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_convert_inline_page
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_find_in_inline_dir
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.rcu_gp_kthread
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.file_update_time
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.memcmp
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.note_interrupt
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.strtol@plt
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp._IO_file_xsputn
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.__blk_mq_sched_dispatch_requests
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.d_splice_alias
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.dd_insert_requests
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.security_inode_free
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.memcg_check_events
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_setattr
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.dma_direct_unmap_sg
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.block_write_begin
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.blk_flush_complete_seq
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_alloc_inode
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.ata_qc_complete_multiple
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.file_remove_privs
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__mutex_init
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__xas_next
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.blk_mq_put_tag
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.mnt_drop_write
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.sd_done
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.dso__get
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.blk_mq_sched_bio_merge
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_release_page
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.perf_exclude_event
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±202%  perf-profile.self.cycles-pp.switch_ldt
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.locate_dirty_segment
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.igb_clean_rx_irq
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__fprop_add_percpu
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__queue_delayed_work
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__rq_qos_done_bio
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.bio_uninit
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_remove_dirty_inode
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.lockref_get
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.update_io_ticks
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.wbt_inflight_cb
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__fxstat@plt
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp._PyLong_New
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__errno_location
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.put_prev_entity
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.ahci_qc_prep
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.dma_direct_map_sg
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_remove_inode_page
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.ata_scsi_rw_xlat
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.ata_scsi_queuecmd
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.radix_tree_node_rcu_free
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.ksys_pwrite64
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp._IO_file_underflow
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±201%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.bio_alloc_bioset
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.check_preempt_curr
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp._PyEval_EvalCodeWithName
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.dd_has_work
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.vfs_fstat
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_do_write_node_page
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__locate_dirty_segment
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_may_inline_data
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.idr_find
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.iov_iter_init
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.sbitmap_queue_clear
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp._PyObject_GenericSetAttrWithDict
      0.05 ± 72%      +0.0        0.05 ±114%      +0.0        0.06 ± 57%  perf-profile.self.cycles-pp.vfs_read
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__blk_mq_run_hw_queue
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__rq_qos_throttle
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.mnt_want_write
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.do_set_pte
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_statfs
      0.00            +0.0        0.00            +0.0        0.01 ±201%  perf-profile.self.cycles-pp.fscrypt_setup_filename
      0.00            +0.0        0.00            +0.0        0.01 ±201%  perf-profile.self.cycles-pp.f2fs_delete_inline_entry
      0.00            +0.0        0.00            +0.0        0.01 ±201%  perf-profile.self.cycles-pp.__wake_up_bit
      0.03 ±102%      +0.0        0.03 ±102%      +0.0        0.04 ± 67%  perf-profile.self.cycles-pp.filemap_add_folio
      0.09 ± 44%      +0.0        0.09 ± 46%      +0.0        0.10 ± 60%  perf-profile.self.cycles-pp.__check_object_size
      0.00            +0.0        0.00            +0.0        0.01 ±203%  perf-profile.self.cycles-pp.free_swap_cache
      0.00            +0.0        0.00            +0.0        0.01 ±203%  perf-profile.self.cycles-pp.get_mem_cgroup_from_objcg
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±124%  perf-profile.self.cycles-pp.fsync
      0.00            +0.0        0.00            +0.0        0.01 ±209%  perf-profile.self.cycles-pp.process_one_work
      0.00            +0.0        0.00            +0.0        0.02 ±152%  perf-profile.self.cycles-pp.PyDict_SetDefault
      0.00            +0.0        0.00            +0.0        0.02 ±153%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.00            +0.0        0.00            +0.0        0.02 ±155%  perf-profile.self.cycles-pp.in_gate_area_no_mm
      0.00            +0.0        0.00            +0.0        0.02 ±156%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.00            +0.0        0.00            +0.0        0.02 ±157%  perf-profile.self.cycles-pp.common_interrupt
      0.00            +0.0        0.00            +0.0        0.02 ±123%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.10 ± 54%      +0.0        0.10 ± 59%      +0.1        0.16 ± 38%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.53 ±  7%      +0.0        0.53 ± 13%      -0.0        0.52 ± 18%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.19 ± 50%      +0.0        0.19 ± 19%      -0.0        0.18 ± 26%  perf-profile.self.cycles-pp.path_openat
      0.40 ± 22%      +0.0        0.41 ± 24%      -0.0        0.36 ± 24%  perf-profile.self.cycles-pp.lookup_fast
      0.08 ± 55%      +0.0        0.08 ± 77%      +0.0        0.09 ± 88%  perf-profile.self.cycles-pp.xas_clear_mark
      0.08 ± 57%      +0.0        0.09 ± 54%      +0.0        0.09 ± 47%  perf-profile.self.cycles-pp.__libc_pwrite
      0.06 ± 61%      +0.0        0.07 ± 47%      +0.0        0.08 ± 47%  perf-profile.self.cycles-pp.read_tsc
      0.02 ±223%      +0.0        0.02 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.fbcon_cursor
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.scsi_complete
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.node_tag_clear
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.PyCode_New
      0.02 ±223%      +0.0        0.02 ±142%      +0.0        0.02 ±156%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.__do_sys_newfstat
      0.02 ±142%      +0.0        0.02 ±141%      +0.0        0.03 ± 82%  perf-profile.self.cycles-pp.update_sit_entry
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.03 ±132%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.02 ±142%      +0.0        0.02 ±144%      +0.0        0.04 ± 86%  perf-profile.self.cycles-pp.f2fs_evict_inode
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.03 ±102%  perf-profile.self.cycles-pp.__folio_memcg_unlock
      0.03 ±142%      +0.0        0.03 ±102%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.f2fs_lookup_rb_tree
      0.13 ± 36%      +0.0        0.14 ± 27%      -0.0        0.12 ± 27%  perf-profile.self.cycles-pp.map_id_up
      0.05 ±100%      +0.0        0.05 ± 73%      +0.0        0.09 ± 34%  perf-profile.self.cycles-pp.cpuacct_charge
      0.03 ±100%      +0.0        0.03 ±146%      +0.0        0.03 ±102%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.vm_area_dup
      0.02 ±223%      +0.0        0.02 ±223%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp.file_ra_state_init
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_set_data_blkaddr
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.xas_init_marks
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.memmove@plt
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.down_read_killable
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±202%  perf-profile.self.cycles-pp.f2fs_file_read_iter
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±165%  perf-profile.self.cycles-pp.opendir
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±156%  perf-profile.self.cycles-pp.pick_next_entity
      0.03 ±101%      +0.0        0.03 ±103%      +0.0        0.04 ±121%  perf-profile.self.cycles-pp._dl_addr
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±154%  perf-profile.self.cycles-pp.check_stack_object
      0.04 ±102%      +0.0        0.05 ±100%      +0.0        0.06 ± 70%  perf-profile.self.cycles-pp.restore_nameidata
      0.02 ±142%      +0.0        0.02 ±142%      +0.0        0.04 ±104%  perf-profile.self.cycles-pp.mntput
      0.04 ±107%      +0.0        0.05 ± 80%      +0.0        0.07 ± 81%  perf-profile.self.cycles-pp.charge_memcg
      0.02 ±142%      +0.0        0.02 ±146%      +0.0        0.05 ±109%  perf-profile.self.cycles-pp.do_sys_open
      0.12 ± 36%      +0.0        0.12 ± 29%      -0.0        0.11 ± 41%  perf-profile.self.cycles-pp.make_kuid
      0.11 ± 33%      +0.0        0.12 ± 21%      +0.0        0.15 ± 42%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.06 ± 81%      +0.0        0.07 ±100%      +0.0        0.08 ± 35%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.04 ±141%      +0.0        0.04 ±103%      +0.0        0.08 ± 80%  perf-profile.self.cycles-pp.down_read
      0.01 ±223%      +0.0        0.02 ±223%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.folio_mapped
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.set_node_addr
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.02 ±124%  perf-profile.self.cycles-pp.get_node_path
      0.02 ±142%      +0.0        0.02 ±143%      +0.0        0.02 ±203%  perf-profile.self.cycles-pp.f2fs_do_write_data_page
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±123%  perf-profile.self.cycles-pp.mod_zone_page_state
      0.04 ± 73%      +0.0        0.05 ±101%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.rb_next
      0.08 ± 56%      +0.0        0.09 ± 27%      +0.0        0.10 ± 29%  perf-profile.self.cycles-pp.f2fs_ra_node_page
      0.22 ± 20%      +0.0        0.22 ± 19%      +0.0        0.23 ± 17%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.27 ± 23%      +0.0        0.28 ± 22%      -0.0        0.27 ± 17%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.18 ± 43%      +0.0        0.19 ± 43%      +0.0        0.18 ± 28%  perf-profile.self.cycles-pp.f2fs_map_blocks
      0.07 ± 19%      +0.0        0.08 ± 50%      +0.0        0.08 ± 79%  perf-profile.self.cycles-pp.apparmor_task_kill
      0.05 ± 76%      +0.0        0.06 ± 81%      -0.0        0.03 ±131%  perf-profile.self.cycles-pp.ktime_get
      0.01 ±223%      +0.0        0.02 ±223%      +0.0        0.02 ±152%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.07 ± 56%      +0.0        0.08 ± 48%      +0.0        0.07 ± 41%  perf-profile.self.cycles-pp.user_path_at_empty
      0.02 ±223%      +0.0        0.02 ±223%      +0.0        0.02 ±158%  perf-profile.self.cycles-pp.bit_putcs
      0.02 ±141%      +0.0        0.02 ±141%      +0.0        0.02 ±122%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.02 ±141%      +0.0        0.03 ±100%      +0.0        0.04 ±109%  perf-profile.self.cycles-pp.process_measurement
      0.03 ±158%      +0.0        0.04 ±105%      -0.0        0.01 ±202%  perf-profile.self.cycles-pp.bpf_ksym_find
      0.04 ± 73%      +0.0        0.05 ± 79%      +0.0        0.05 ± 76%  perf-profile.self.cycles-pp.pagevec_add_and_need_flush
      0.12 ± 31%      +0.0        0.12 ± 22%      +0.0        0.12 ± 34%  perf-profile.self.cycles-pp.f2fs_getattr
      0.12 ± 36%      +0.0        0.12 ± 36%      +0.0        0.14 ± 31%  perf-profile.self.cycles-pp.audit_signal_info_syscall
      0.04 ± 72%      +0.0        0.05 ± 82%      -0.0        0.03 ±130%  perf-profile.self.cycles-pp.filemap_get_pages
      0.05 ±117%      +0.0        0.06 ± 82%      -0.0        0.05 ± 92%  perf-profile.self.cycles-pp.__do_sys_newstat
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.pagevec_lookup_range_tag
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.mem_cgroup_charge_statistics
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.perf_iterate_sb
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.PyParser_AddToken
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.perf_misc_flags
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.scsi_done
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.pipe_read
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.vfs_rename
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.xas_alloc
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__radix_tree_delete
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.inode_init_always
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.lockref_get_not_zero
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.rcu_segcblist_accelerate
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__slab_alloc
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__dsos__findnew_link_by_longname_id
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.PyUnicode_New
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_inode_chksum_verify
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.folio_wait_bit
      0.01 ±223%      +0.0        0.02 ±223%      +0.0        0.02 ±159%  perf-profile.self.cycles-pp.do_unlinkat
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.free_pcp_prepare
      0.02 ±142%      +0.0        0.03 ±100%      +0.0        0.02 ±125%  perf-profile.self.cycles-pp.try_to_unlazy
      0.04 ±102%      +0.0        0.05 ± 81%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.may_open
      0.09 ± 62%      +0.0        0.10 ± 52%      -0.0        0.08 ± 56%  perf-profile.self.cycles-pp.__open64_nocancel
      0.06 ± 47%      +0.0        0.07 ± 71%      +0.0        0.08 ± 57%  perf-profile.self.cycles-pp.do_open
      0.33 ± 18%      +0.0        0.34 ± 21%      +0.1        0.40 ± 21%  perf-profile.self.cycles-pp._raw_spin_lock
      0.14 ± 55%      +0.0        0.15 ± 42%      -0.0        0.10 ± 42%  perf-profile.self.cycles-pp.vfs_statx
      0.03 ±102%      +0.0        0.04 ±115%      +0.0        0.04 ± 84%  perf-profile.self.cycles-pp.aa_file_perm
      0.03 ±108%      +0.0        0.04 ±104%      +0.0        0.05 ± 68%  perf-profile.self.cycles-pp.check_kill_permission
      0.11 ± 35%      +0.0        0.12 ± 31%      +0.0        0.14 ± 17%  perf-profile.self.cycles-pp.open64
      0.02 ±144%      +0.0        0.03 ±101%      +0.0        0.03 ±102%  perf-profile.self.cycles-pp.page_counter_cancel
      0.01 ±223%      +0.0        0.02 ±142%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_lookup
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__f2fs_get_acl
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.f2fs_do_read_inline_data
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.radix_tree_lookup
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.file_write_and_wait_range
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.f2fs_outplace_write_data
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.filename_parentat
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.workingset_update_node
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.01 ±203%  perf-profile.self.cycles-pp.security_file_open
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.timekeeping_advance
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.security_task_getsecid_subj
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.filemap_map_pages
      0.05 ± 76%      +0.0        0.06 ± 76%      +0.0        0.08 ± 39%  perf-profile.self.cycles-pp.current_time
      0.18 ± 17%      +0.0        0.20 ± 35%      +0.0        0.19 ± 21%  perf-profile.self.cycles-pp.@plt
      0.29 ± 25%      +0.0        0.30 ± 24%      -0.0        0.28 ± 29%  perf-profile.self.cycles-pp.readdir64
      0.18 ± 28%      +0.0        0.19 ± 19%      +0.0        0.18 ± 30%  perf-profile.self.cycles-pp.__folio_mark_dirty
      0.01 ±223%      +0.0        0.02 ±144%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.f2fs_init_inode_metadata
      0.01 ±223%      +0.0        0.02 ±144%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.sd_setup_read_write_cmnd
      0.01 ±223%      +0.0        0.02 ±144%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.vfs_getattr
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.dnotify_flush
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.pagevec_lru_move_fn
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__rblist__findnew
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__bio_try_merge_page
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__block_commit_write
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.current_umask
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.generic_file_read_iter
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.kthread_should_stop
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.page_mapping
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.vfs_statfs
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.xattr_resolve_name
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.open@plt
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.pread@plt
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__irqentry_text_start
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.ksys_read
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.alloc_page_buffers
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.unmap_vmas
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.statfs_by_dentry
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.trigger_load_balance
      0.01 ±223%      +0.0        0.02 ±144%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.do_renameat2
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_truncate_inode_blocks
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.perf_output_put_handle
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.policy_node
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.ftrace_ops_trampoline
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__d_move
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.submit_flush_wait
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.vfprintf
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.iput
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±152%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.readdir@plt
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.page_counter_charge
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.03 ±101%  perf-profile.self.cycles-pp.__lookup_nat_cache
      0.04 ±146%      +0.0        0.05 ± 47%      -0.0        0.03 ±103%  perf-profile.self.cycles-pp.memalign@plt
      0.12 ± 64%      +0.0        0.13 ± 12%      +0.0        0.12 ± 58%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.21 ±  9%      +0.0        0.22 ± 22%      +0.0        0.26 ± 24%  perf-profile.self.cycles-pp.__get_node_page
      0.15 ± 24%      +0.0        0.17 ± 39%      +0.0        0.16 ± 22%  perf-profile.self.cycles-pp._PyEval_EvalFrameDefault
      0.02 ±144%      +0.0        0.03 ±157%      +0.0        0.05 ± 84%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.f2fs_do_add_link
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.copyin
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±155%  perf-profile.self.cycles-pp.set_page_dirty
      0.05 ± 77%      +0.0        0.06 ±116%      -0.0        0.02 ±162%  perf-profile.self.cycles-pp.delay_halt
      0.02 ±142%      +0.0        0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.f2fs_lookup_extent_cache
      0.04 ±107%      +0.0        0.06 ± 73%      +0.0        0.06 ± 53%  perf-profile.self.cycles-pp.submit_bio_checks
      0.21 ± 28%      +0.0        0.22 ± 21%      +0.0        0.24 ±  9%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.41 ± 13%      +0.0        0.43 ± 19%      -0.1        0.33 ± 21%  perf-profile.self.cycles-pp.xas_start
      0.38 ± 13%      +0.0        0.39 ± 24%      -0.0        0.34 ± 14%  perf-profile.self.cycles-pp.f2fs_write_begin
      0.35 ± 13%      +0.0        0.36 ± 22%      -0.0        0.31 ± 22%  perf-profile.self.cycles-pp.__might_sleep
      0.02 ±223%      +0.0        0.03 ±101%      -0.0        0.01 ±203%  perf-profile.self.cycles-pp.f2fs_set_node_page_dirty
      0.05 ± 72%      +0.0        0.06 ± 52%      +0.0        0.06 ± 63%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.04 ±106%      +0.0        0.05 ± 46%      +0.0        0.07 ± 64%  perf-profile.self.cycles-pp.touch_atime
      0.00            +0.0        0.02 ±223%      +0.0        0.03 ±103%  perf-profile.self.cycles-pp.__activate_page
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.find_vma
      0.02 ±141%      +0.0        0.03 ±100%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.f2fs_do_sync_file
      0.02 ±223%      +0.0        0.03 ±102%      +0.0        0.05 ± 87%  perf-profile.self.cycles-pp.f2fs_preallocate_blocks
      0.04 ±102%      +0.0        0.06 ±102%      +0.1        0.10 ± 21%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.72 ± 12%      +0.0        0.74 ± 12%      +0.0        0.73 ± 14%  perf-profile.self.cycles-pp.map_id_range_down
      0.08 ± 58%      +0.0        0.10 ± 51%      -0.0        0.06 ± 71%  perf-profile.self.cycles-pp.__enqueue_entity
      0.07 ± 59%      +0.0        0.08 ± 53%      +0.0        0.07 ± 73%  perf-profile.self.cycles-pp.folio_memcg_lock
      0.04 ±104%      +0.0        0.06 ±108%      +0.0        0.05 ± 56%  perf-profile.self.cycles-pp.blk_mq_submit_bio
      0.00            +0.0        0.02 ±223%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.kill@plt
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.add_interrupt_randomness
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.04 ±107%  perf-profile.self.cycles-pp.strstr@plt
      0.15 ± 24%      +0.0        0.17 ± 41%      -0.0        0.11 ± 47%  perf-profile.self.cycles-pp.f2fs_read_inline_dir
      0.39 ± 29%      +0.0        0.41 ± 20%      -0.0        0.35 ± 30%  perf-profile.self.cycles-pp.walk_component
      0.18 ± 15%      +0.0        0.20 ± 27%      +0.0        0.19 ± 30%  perf-profile.self.cycles-pp.f2fs_create
      0.01 ±223%      +0.0        0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.xa_get_order
      0.00            +0.0        0.02 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.write_cache_pages
      0.00            +0.0        0.02 ±142%      +0.0        0.00        perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.0        0.02 ±142%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.mempool_alloc
      0.00            +0.0        0.02 ±142%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.inode_init_once
      0.00            +0.0        0.02 ±142%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp._PyFunction_FastCallKeywords
      0.00            +0.0        0.02 ±223%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__set_nat_cache_dirty
      0.00            +0.0        0.02 ±142%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp._PyDict_LoadGlobal
      0.06 ± 73%      +0.0        0.08 ± 82%      +0.0        0.07 ± 56%  perf-profile.self.cycles-pp.getname_flags
      0.00            +0.0        0.02 ±144%      +0.0        0.00        perf-profile.self.cycles-pp.mod_node_page_state
      0.02 ±149%      +0.0        0.04 ±112%      +0.0        0.03 ±125%  perf-profile.self.cycles-pp.next_uptodate_page
      0.00            +0.0        0.02 ±144%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.vfs_open
      0.00            +0.0        0.02 ±144%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.bio_associate_blkg_from_css
      0.00            +0.0        0.02 ±144%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.00            +0.0        0.02 ±144%      +0.0        0.02 ±204%  perf-profile.self.cycles-pp.ima_file_free
      0.01 ±223%      +0.0        0.03 ±144%      -0.0        0.00        perf-profile.self.cycles-pp.do_write_page
      0.01 ±223%      +0.0        0.03 ±144%      +0.0        0.02 ±200%  perf-profile.self.cycles-pp.copy_pte_range
      0.25 ± 19%      +0.0        0.27 ± 18%      -0.0        0.24 ± 29%  perf-profile.self.cycles-pp.f2fs_build_node_manager
      0.16 ± 29%      +0.0        0.18 ± 15%      +0.0        0.16 ± 24%  perf-profile.self.cycles-pp._IO_fgets
      0.17 ± 26%      +0.0        0.19 ± 14%      +0.0        0.19 ± 35%  perf-profile.self.cycles-pp.do_sys_openat2
      0.08 ± 25%      +0.0        0.10 ± 30%      -0.0        0.08 ± 47%  perf-profile.self.cycles-pp.bitfill_aligned
      0.01 ±223%      +0.0        0.03 ±146%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.vsnprintf
      0.00            +0.0        0.02 ±142%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.group_send_sig_info
      0.00            +0.0        0.02 ±142%      +0.0        0.02 ±130%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.08 ± 90%      +0.0        0.11 ± 80%      +0.0        0.11 ± 29%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.10 ± 32%      +0.0        0.12 ± 34%      +0.0        0.13 ± 35%  perf-profile.self.cycles-pp.free_unref_page_list
      0.05 ±111%      +0.0        0.07 ± 81%      +0.0        0.09 ± 26%  perf-profile.self.cycles-pp.f2fs_readdir
      0.15 ± 29%      +0.0        0.18 ± 23%      +0.1        0.22 ± 27%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.03 ±147%      +0.0        0.05 ± 83%      +0.0        0.03 ±108%  perf-profile.self.cycles-pp.unlock_page
      0.06 ± 13%      +0.0        0.08 ± 27%      +0.0        0.06 ± 62%  perf-profile.self.cycles-pp.fd_install
      0.00            +0.0        0.02 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.string_nocheck
      0.02 ±152%      +0.0        0.05 ± 80%      +0.0        0.03 ±105%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.02 ±141%      +0.0        0.04 ± 75%      +0.0        0.04 ± 87%  perf-profile.self.cycles-pp.blk_update_request
      0.00            +0.0        0.02 ±143%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.up_write
      0.01 ±223%      +0.0        0.03 ±102%      -0.0        0.00        perf-profile.self.cycles-pp.__remove_ino_entry
      0.02 ±142%      +0.0        0.04 ±141%      -0.0        0.02 ±156%  perf-profile.self.cycles-pp.__xa_set_mark
      0.04 ±109%      +0.0        0.06 ± 48%      +0.0        0.04 ±106%  perf-profile.self.cycles-pp.should_failslab
      0.01 ±223%      +0.0        0.03 ±108%      +0.0        0.03 ±106%  perf-profile.self.cycles-pp.copy_page
      0.00            +0.0        0.02 ±145%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.map__new
      0.03 ±102%      +0.0        0.05 ± 73%      +0.0        0.04 ± 84%  perf-profile.self.cycles-pp.deactivate_file_page
      0.04 ±104%      +0.0        0.07 ± 77%      -0.0        0.04 ±110%  perf-profile.self.cycles-pp.__strdup
      0.01 ±223%      +0.0        0.04 ±112%      +0.0        0.03 ±125%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.29 ±  5%      +0.0        0.32 ± 27%      -0.0        0.27 ± 16%  perf-profile.self.cycles-pp.xas_find
      0.01 ±223%      +0.0        0.04 ±141%      +0.0        0.01 ±206%  perf-profile.self.cycles-pp.fbcon_redraw
      0.02 ±142%      +0.0        0.05 ± 80%      +0.0        0.03 ±101%  perf-profile.self.cycles-pp.security_task_kill
      0.33 ± 31%      +0.0        0.36 ± 19%      +0.0        0.35 ± 24%  perf-profile.self.cycles-pp.f2fs_find_target_dentry
      0.04 ±107%      +0.0        0.07 ± 53%      +0.0        0.04 ± 89%  perf-profile.self.cycles-pp.up_read
      0.08 ± 51%      +0.0        0.10 ± 18%      -0.0        0.07 ± 57%  perf-profile.self.cycles-pp.security_file_permission
      0.04 ±142%      +0.0        0.07 ± 55%      +0.0        0.05 ± 68%  perf-profile.self.cycles-pp.pid_task
      0.03 ±163%      +0.0        0.06 ± 73%      +0.0        0.05 ± 71%  perf-profile.self.cycles-pp.gettimeofday@plt
      0.04 ±102%      +0.0        0.06 ± 55%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.strncasecmp
      0.07 ± 58%      +0.0        0.10 ± 33%      +0.0        0.07 ± 49%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.05 ± 90%      +0.0        0.08 ± 20%      +0.0        0.09 ± 43%  perf-profile.self.cycles-pp.__libc_calloc
      0.10 ± 19%      +0.0        0.13 ± 59%      +0.0        0.11 ± 42%  perf-profile.self.cycles-pp.fault_in_readable
      0.00            +0.0        0.03 ±146%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.f2fs_init_extent_tree
      0.06 ± 82%      +0.0        0.08 ± 56%      +0.0        0.07 ± 42%  perf-profile.self.cycles-pp.drop_pagecache_sb
      0.02 ±223%      +0.0        0.04 ± 79%      +0.0        0.04 ± 84%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.05 ±104%      +0.0        0.08 ± 27%      +0.0        0.08 ± 41%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.09 ± 60%      +0.0        0.12 ± 26%      +0.0        0.12 ± 61%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.19 ± 54%      +0.0        0.22 ± 27%      +0.0        0.21 ± 36%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.02 ±141%      +0.0        0.05 ±108%      +0.0        0.04 ± 84%  perf-profile.self.cycles-pp.__generic_file_write_iter
      0.00            +0.0        0.03 ±103%      +0.0        0.04 ±103%  perf-profile.self.cycles-pp.kfree
      0.02 ±143%      +0.0        0.06 ± 76%      +0.0        0.02 ±123%  perf-profile.self.cycles-pp.__set_data_blkaddr
      0.04 ±101%      +0.0        0.07 ± 54%      +0.0        0.08 ± 43%  perf-profile.self.cycles-pp.refill_obj_stock
      0.00            +0.0        0.04 ±105%      +0.0        0.03 ±101%  perf-profile.self.cycles-pp.filemap_alloc_folio
      0.07 ± 18%      +0.0        0.11 ± 49%      +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.perf_tp_event
      0.27 ± 26%      +0.0        0.30 ± 17%      +0.0        0.30 ± 27%  perf-profile.self.cycles-pp.f2fs_fill_dentries
      0.16 ± 16%      +0.0        0.19 ± 29%      +0.0        0.16 ± 27%  perf-profile.self.cycles-pp.rcu_all_qs
      0.11 ± 26%      +0.0        0.14 ± 69%      +0.0        0.14 ± 30%  perf-profile.self.cycles-pp.f2fs_new_node_page
      0.01 ±223%      +0.0        0.05 ±103%      +0.0        0.02 ±125%  perf-profile.self.cycles-pp.__f2fs_setup_filename
      0.01 ±223%      +0.0        0.05 ±111%      +0.0        0.05 ± 72%  perf-profile.self.cycles-pp.free@plt
      0.14 ± 51%      +0.0        0.18 ± 21%      -0.0        0.14 ± 38%  perf-profile.self.cycles-pp.f2fs_write_end
      0.08 ± 57%      +0.0        0.11 ± 30%      +0.0        0.11 ± 29%  perf-profile.self.cycles-pp.__raw_callee_save___native_queued_spin_unlock
      0.22 ± 19%      +0.0        0.26 ± 25%      +0.1        0.28 ± 14%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.06 ± 75%      +0.0        0.09 ± 26%      +0.0        0.08 ± 42%  perf-profile.self.cycles-pp.xas_set_mark
      0.06 ± 72%      +0.0        0.10 ± 30%      +0.0        0.08 ± 61%  perf-profile.self.cycles-pp.xas_create
      0.01 ±223%      +0.0        0.05 ±109%      +0.0        0.01 ±203%  perf-profile.self.cycles-pp.prep_new_page
      0.00            +0.0        0.04 ±152%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.format_decode
      0.01 ±223%      +0.0        0.05 ± 80%      +0.0        0.02 ±154%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.02 ±141%      +0.0        0.06 ± 78%      +0.0        0.03 ±101%  perf-profile.self.cycles-pp.f2fs_build_segment_manager
      0.16 ± 47%      +0.0        0.20 ± 33%      +0.1        0.21 ± 28%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.04 ± 72%      +0.0        0.08 ± 59%      -0.0        0.04 ± 84%  perf-profile.self.cycles-pp.new_sync_write
      0.12 ± 23%      +0.0        0.16 ± 32%      +0.0        0.15 ± 39%  perf-profile.self.cycles-pp.clear_page_erms
      0.08 ± 51%      +0.0        0.12 ± 41%      +0.0        0.09 ± 53%  perf-profile.self.cycles-pp.perf_output_sample
      0.00            +0.0        0.04 ± 73%      +0.0        0.02 ±177%  perf-profile.self.cycles-pp.pick_file
      0.15 ± 28%      +0.0        0.19 ± 51%      +0.1        0.20 ± 28%  perf-profile.self.cycles-pp._find_next_bit
      0.13 ± 45%      +0.0        0.18 ± 20%      -0.0        0.12 ± 46%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.04 ±107%      +0.0        0.09 ± 46%      +0.0        0.09 ± 32%  perf-profile.self.cycles-pp.___perf_sw_event
      0.26 ± 15%      +0.0        0.31 ± 26%      +0.0        0.31 ± 23%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.0        0.05 ±119%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.number
      0.00            +0.0        0.05 ±174%      +0.0        0.02 ±300%  perf-profile.self.cycles-pp.kallsyms__parse
      0.04 ± 75%      +0.1        0.09 ± 56%      +0.0        0.05 ± 85%  perf-profile.self.cycles-pp.__close_nocancel
      0.11 ± 30%      +0.1        0.16 ± 31%      +0.0        0.12 ± 32%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.14 ± 37%      +0.1        0.19 ± 24%      +0.0        0.17 ± 19%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.09 ± 47%      +0.1        0.14 ± 66%      +0.0        0.12 ± 31%  perf-profile.self.cycles-pp.__fput
      0.06 ± 75%      +0.1        0.11 ± 29%      -0.0        0.05 ± 53%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.12 ± 37%      +0.1        0.18 ± 39%      +0.1        0.19 ± 23%  perf-profile.self.cycles-pp.cfree
      0.12 ± 24%      +0.1        0.18 ± 30%      +0.0        0.16 ± 30%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.06 ± 76%      +0.1        0.12 ± 49%      +0.0        0.08 ± 25%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.11 ± 75%      +0.1        0.17 ± 42%      +0.0        0.12 ± 42%  perf-profile.self.cycles-pp.f2fs_balance_fs
      0.16 ± 27%      +0.1        0.22 ± 14%      +0.0        0.18 ± 30%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.94 ± 11%      +0.1        1.01 ± 21%      +0.1        1.06 ± 17%  perf-profile.self.cycles-pp.xas_find_marked
      0.00            +0.1        0.06 ±142%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.map__process_kallsym_symbol
      0.00            +0.1        0.06 ±139%      +0.0        0.02 ±299%  perf-profile.self.cycles-pp.kallsyms_expand_symbol
      0.76 ± 18%      +0.1        0.82 ± 34%      +0.2        0.91 ± 16%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.05 ± 75%      +0.1        0.11 ± 21%      +0.0        0.09 ± 50%  perf-profile.self.cycles-pp.vfs_write
      0.88 ±  8%      +0.1        0.94 ± 12%      +0.0        0.90 ± 15%  perf-profile.self.cycles-pp.filldir64
      0.24 ± 26%      +0.1        0.30 ± 18%      -0.0        0.19 ± 15%  perf-profile.self.cycles-pp.rmqueue
      0.09 ± 52%      +0.1        0.16 ± 29%      +0.1        0.16 ± 37%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      1.00 ±  7%      +0.1        1.07 ± 18%      +0.0        1.03 ±  9%  perf-profile.self.cycles-pp.__might_resched
      0.24 ± 28%      +0.1        0.33 ± 21%      +0.0        0.28 ± 14%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.20 ± 32%      +0.1        0.30 ± 24%      +0.0        0.22 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.44 ± 17%      +0.1        0.56 ± 30%      -0.1        0.37 ± 21%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.02 ± 13%      +0.1        1.16 ±  9%      +0.0        1.06 ± 15%  perf-profile.self.cycles-pp.link_path_walk
      0.20 ± 33%      +0.1        0.34 ± 24%      +0.0        0.23 ± 31%  perf-profile.self.cycles-pp.intel_idle
      0.81 ±  7%      +0.2        1.01 ± 36%      +0.1        0.91 ± 27%  perf-profile.self.cycles-pp.f2fs_fsync_node_pages
      2.65 ±  4%      +0.2        2.86 ± 24%      -0.1        2.58 ± 17%  perf-profile.self.cycles-pp.pit_next_event
      1.46 ± 16%      +0.3        1.71 ± 21%      -0.0        1.45 ± 16%  perf-profile.self.cycles-pp.native_io_delay
      1.05 ± 41%      +0.3        1.31 ± 50%      -0.1        0.96 ± 42%  perf-profile.self.cycles-pp.delay_halt_tpause
      1.16 ± 37%      +0.4        1.55 ± 48%      -0.1        1.03 ± 37%  perf-profile.self.cycles-pp.mem_serial_in
      3.93 ±  3%      +0.5        4.42 ±  7%      +0.1        4.03 ±  4%  perf-profile.self.cycles-pp.update_free_nid_bitmap
      9.21 ±  6%      +0.7        9.88 ±  4%      +0.1        9.30 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      2.03 ± 31%      +0.9        2.88 ± 52%      -0.1        1.95 ± 34%  perf-profile.self.cycles-pp.cfb_imageblit

xsang@inn:~$

--mYCpIKhGyMATD0i+--
