Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6558DA98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiHIO4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHIOz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:55:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8942813DF5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660056957; x=1691592957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/y03tk8Vi+r4ivUpOIzB1qW/+LcKMkgnnn79oUwijQA=;
  b=QtbS3kKkh2dAbPysjIzeNA4+RGWi6azojfPPJ7ejgj5M91545ChOS9bp
   /grPL94DoBHl3E2nq0sGbGID6LLOADsIQIzy5lAVx+Vaw0yWRcpGAuaXA
   c64lt6liyLrXr4+P9bWiwlafddrVgzKwTvIcrJP82SQeyg29U+iEPQmEE
   2Q3zQo3Ar3NTl6rlsJ4UTvzxCTforkcZhOiGqEC09eZg87pQGGp7v/O7X
   0ndyDdxeqVw71PWytfUFbuO96glmmLelre4ag+j806FI/Xuodo+1IsqSe
   10YpOjKT8uYJD2tCNAI3Nkeeb+DHCSSEwBul8ZX/T4twK07gPEmL5dB+S
   g==;
X-IronPort-AV: E=Sophos;i="5.93,224,1654531200"; 
   d="scan'208";a="206746658"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2022 22:55:56 +0800
IronPort-SDR: 2OUhayqqtK/Cz4/xnzcUD0ubAFXOhQzfFvvwwrie6S+davANR2REAZAy4WGyhB3hS806k9ufp/
 JgvxLBJtWOPFAeeguoqKLSflEZ64OBykOrtf6YA/WscaSxaRUtVENkI/v7JvUWoj+NDTQZZGBl
 elA3YKlEfnbQsIcA/8rOInyxG9xrazToXYQDC+AMUvRd7uq6AEgb6R7+9wjDzJ94M/GRQi8jyG
 RcxsoG56LJRu1BRxzyupyhHUd8/OpuWHzhhwSMCWXU18E0TdD1kElMhJnwniAv2l06v+KVGB8W
 EObvXCB4IJ+bZVnO4np3+zaQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2022 07:11:36 -0700
IronPort-SDR: k3PinRxT9HQAEpSSoUeDi2FprGWEE2wzULUq2YR97wEosztTO2ERW1u8ldg5gMOzCGP6siJ+nL
 4sSrIFlDRwLJF7MElkfKs3q4PLXf2unyghB++xXkvUN1Zro5p1lD6EpY9rSavKTzKPmOcqKvfG
 bAydt7Nk11mkSf15m4KErDu0cWtfU0aApmyWJSOJQLmmQOA0HOdABQxJgj0p1+0DKmrQKJUgVG
 5IluccMGq5JdpExzHZZMBRVDpTUsyElbcTFb+bSdpaIz84zSbOGbkVHqyuPgYlFiWw2BH4qoE+
 ORA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2022 07:55:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2GND0nJcz1Rw4L
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:55:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660056954; x=1662648955; bh=/y03tk8Vi+r4ivUpOIzB1qW/+LcKMkgnnn7
        9oUwijQA=; b=YNEtop4DprzBm70dwiE9MmTa4GQNcwnbxPG71WIfihcSK1PM3+b
        TAD4DKNN5x12SFJeUKZuQpYh9X1OSo+OWYqSxhD7oFdIUjlGU13CchNadVF6Pesi
        vqXjsvbL+dFANoTuNegdW+eLcJ10jPxb9xbod0GJ1W9gtgLUqnqAIgMs8YCaTTMJ
        pjxH/aRKEbycQXRxr551JPdzF41eSfa6f8pLAsJTZVG0Gq5DhuXolct0pK8Ss9B5
        SRo8uhFdyQzwrvk9B0cZXtF2ZQI1MawhbVsuk9+HaIXpQjlXLNQH+27yNlJ19ppx
        eIf7DOMoZ8X0r/H03JNTkjaLFjEtpZIyMPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OEwpR28uqAhI for <linux-kernel@vger.kernel.org>;
        Tue,  9 Aug 2022 07:55:54 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2GN94KBrz1RtVk;
        Tue,  9 Aug 2022 07:55:53 -0700 (PDT)
Message-ID: <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
Date:   Tue, 9 Aug 2022 07:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ide@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/09 2:58, John Garry wrote:
> On 08/08/2022 15:52, Damien Le Moal wrote:
>> On 2022/08/05 1:05, kernel test robot wrote:
>>>
>>>
>>> Greeting,
>>>
>>> FYI, we noticed a -15.0% regression of stress-ng.copy-file.ops_per_se=
c due to commit:
>>>
>>>
>>> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: libata-scsi: =
cap ata_device->max_sectors according to shost->max_sectors")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
>>>
>>> in testcase: stress-ng
>>> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
>>> with following parameters:
>>>
>>> 	nr_threads: 10%
>>> 	disk: 1HDD
>>> 	testtime: 60s
>>> 	fs: f2fs
>>> 	class: filesystem
>>> 	test: copy-file
>>> 	cpufreq_governor: performance
>>> 	ucode: 0xb000280
>>
>> Without knowing what the device adapter is, hard to say where the prob=
lem is. I
>> suspect that with the patch applied, we may be ending up with a small =
default
>> max_sectors value, causing overhead due to more commands than necessar=
y.
>>
>> Will check what I see with my test rig.
>=20
> As far as I can see, this patch should not make a difference unless the=
=20
> ATA shost driver is setting the max_sectors value unnecessarily low.

That is my hunch too, hence my question about which host driver is being =
used
for this test... That is not apparent from the problem report.

>=20
>>
>>>
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> Details are as below:
>>> ---------------------------------------------------------------------=
----------------------------->
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          sudo bin/lkp install job.yaml           # job file is attach=
ed in this email
>>>          bin/lkp split-job --compatible job.yaml # generate the yaml =
file for lkp run
>>>          sudo bin/lkp run generated-yaml-file
>>>
>>>          # if come across any failure that blocks the test,
>>>          # please remove ~/.lkp and /lkp dir to run from a clean stat=
e.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbo=
x_group/test/testcase/testtime/ucode:
>>>    filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/debian=
-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/copy-file/stress-ng/60s/0xb000280
>>>
>>> commit:
>>>    4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors accor=
ding to DMA optimal limit")
>>>    0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors accordi=
ng to shost->max_sectors")
>>>
>>> 4cbfca5f7750520f 0568e6122574dcc1aded2979cd0
>>> ---------------- ---------------------------
>>>           %stddev     %change         %stddev
>>>               \          |                \
>>>        1627           -14.9%       1385        stress-ng.copy-file.op=
s
>>>       27.01           -15.0%      22.96        stress-ng.copy-file.op=
s_per_sec
>>>     8935079           -11.9%    7870629        stress-ng.time.file_sy=
stem_outputs
>>>       14.88 =C2=B1  5%     -31.8%      10.14 =C2=B1  3%  stress-ng.ti=
me.percent_of_cpu_this_job_got
>>>       50912           -14.7%      43413        vmstat.io.bo
>>>       93.78            +1.4%      95.10        iostat.cpu.idle
>>>        3.89           -31.6%       2.66        iostat.cpu.iowait
>>>        4.01            -1.3        2.74        mpstat.cpu.all.iowait%
>>>        0.23 =C2=B1  9%      -0.1        0.17 =C2=B1 11%  mpstat.cpu.a=
ll.sys%
>>>        1.66 =C2=B1 37%      -1.2        0.51 =C2=B1 55%  perf-profile=
.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.f2fs_buffered_w=
rite_iter.f2fs_file_write_iter.do_iter_readv_writev
>>>        1.66 =C2=B1 37%      -1.1        0.59 =C2=B1 25%  perf-profile=
.children.cycles-pp.f2fs_write_end
>>>        1.51 =C2=B1 40%      -1.1        0.45 =C2=B1 26%  perf-profile=
.children.cycles-pp.f2fs_dirty_data_folio
>>>        1.21 =C2=B1 49%      -1.0        0.23 =C2=B1 33%  perf-profile=
.children.cycles-pp.f2fs_update_dirty_folio
>>>        0.88 =C2=B1 56%      -0.8        0.04 =C2=B1111%  perf-profile=
.children.cycles-pp.native_queued_spin_lock_slowpath
>>>        0.14 =C2=B1 26%      +0.1        0.25 =C2=B1 28%  perf-profile=
.children.cycles-pp.page_cache_ra_unbounded
>>>        0.88 =C2=B1 56%      -0.8        0.04 =C2=B1112%  perf-profile=
.self.cycles-pp.native_queued_spin_lock_slowpath
>>>     3164876 =C2=B1  9%     -20.2%    2524713 =C2=B1  7%  perf-stat.i.=
cache-misses
>>>   4.087e+08            -4.6%  3.899e+08        perf-stat.i.dTLB-loads
>>>      313050 =C2=B1 10%     -18.4%     255410 =C2=B1  6%  perf-stat.i.=
node-loads
>>>      972573 =C2=B1  9%     -16.4%     812873 =C2=B1  6%  perf-stat.i.=
node-stores
>>>     3114748 =C2=B1  9%     -20.2%    2484807 =C2=B1  7%  perf-stat.ps=
.cache-misses
>>>   4.022e+08            -4.6%  3.837e+08        perf-stat.ps.dTLB-load=
s
>>>      308178 =C2=B1 10%     -18.4%     251418 =C2=B1  6%  perf-stat.ps=
.node-loads
>>>      956996 =C2=B1  9%     -16.4%     799948 =C2=B1  6%  perf-stat.ps=
.node-stores
>>>      358486            -8.3%     328694        proc-vmstat.nr_active_=
file
>>>     1121620           -11.9%     987816        proc-vmstat.nr_dirtied
>>>      179906            -6.7%     167912        proc-vmstat.nr_dirty
>>>     1151201            -1.7%    1131322        proc-vmstat.nr_file_pa=
ges
>>>      100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.nr_in=
active_file
>>>      846362           -14.6%     722471        proc-vmstat.nr_written
>>>      358486            -8.3%     328694        proc-vmstat.nr_zone_ac=
tive_file
>>>      100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.nr_zo=
ne_inactive_file
>>>      180668            -6.8%     168456        proc-vmstat.nr_zone_wr=
ite_pending
>>>      556469            -3.5%     536985        proc-vmstat.pgactivate
>>>     3385454           -14.6%    2889953        proc-vmstat.pgpgout
>>>
>>>
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are =
provided
>>> for informational purposes only. Any difference in system hardware or=
 software
>>> design or configuration may affect actual performance.
>>>
>>>
>>
>>
>=20


--=20
Damien Le Moal
Western Digital Research
