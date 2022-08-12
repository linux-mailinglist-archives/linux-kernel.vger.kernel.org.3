Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C801591333
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiHLPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiHLPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:42:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C18286C2A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660318922; x=1691854922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WHpBj2fHK1J03Ty6/XHGyBT8jtP16mzYLHAEXWEsj5w=;
  b=VNTsC4PPxekWt1GA5+IzHMwsQthozHSjDZ/oV5uWe1umynjB9ci+QDrX
   TlJ06HgDMhjTNgmRl6s9xy9OoaGH7Eebam6sXSn08ei7eCq1fGlSW4UrG
   YAyc8oLI2SNIvdiW994Fv/vgr/1d3v6XCcQxZHyxDtnTLhYFAxHZh3g6j
   YumM4g8ltVdPXcY7KukZUZL5dlOOPrSn28icCgR5avZzLu14PR6ohJF/b
   PPJVDY6zz1c8LxNGXKAdyNf1UesvAXtH0z47T0lE/4nmSzl88zAqMvG/3
   BAOw1kFckMcKIksvQirAGfVcBgrgpWPJg4ow8Cx801RuFdXQfnx2w1IhH
   w==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654531200"; 
   d="scan'208";a="312838538"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 23:41:57 +0800
IronPort-SDR: Z+qgOmXJsayEHwtiJhx87Ha/fE1CWD32sHfrfeDPkzOozn8PbdnAuHTvONVzn+yW2vKQTn4OKo
 Z3rnSRbQi68EHldbxcy+sfAa0yKZfs7tLcAv/mkMCUdv1ZkWLNMYC0fd25geagPX7v1xH0Xv9T
 mAv4OW/x0TSSBcurFEAOVPZ6Xm9Ik3gCp30lLL2aYocucv3zbRcwQJcv8k0GAZ3D01nzLuLD/B
 u70RldfbpAn/CNIb3dw3s6azobobZ+6UbycooSpwT8eq+U9BAIVX7xsjtRm2X5iq3hkmztRWWU
 IJ3wWihW1BpN3dg1y2du8xjp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 07:57:30 -0700
IronPort-SDR: ZzrdFSLTRFZUtt4UTzO9NlfgFiR4Szt5yYv2ocfuJCG17hmRcEl483OA7ppgwKTHTNt62MWCQM
 WdBk77EKDTxcEJccVRjYXObED8bbTwc9e22uPIdZNZUC0Gl3uCWxYj4hwUesKZKyy77yTexfIT
 3+vDWuliNhg5cwQBUlhqB+1fubFITrExv6rZnmHSCPDnPg00vaXZPFSY59y2f6GtQSRmoBhjei
 GlyRxHASoJKmxgCZj9NUjMxdk6qzn5EnXIYAkJ67Q31u5kA5tZlGm6YQUEdNRHQFiKoopO/zUa
 uiM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 08:41:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M47Fx0VfHz1Rwry
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:41:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660318914; x=1662910915; bh=WHpBj2fHK1J03Ty6/XHGyBT8jtP16mzYLHA
        EXWEsj5w=; b=VFe63nZcz3NZx70SVbvpubAiidIN9P0gA1n2KGOUAc68dgqV1xf
        h4er45oqDLowu8yxjPZjGXk6a2tFBnFANT/GHNRASNVnaVlDP2ayuMBZaSHpWJx0
        4AJ3FofnYN2hvrRPOQqgIvOYkIYbQHaoixh2CGopMAhdXiZp3hPQOTgh98hxBr+8
        UDCgmzWKfiE/k7aeVfecj/2y1qTPtvyQs8wPzI+e897FssMidqLYuc/c95bXamcB
        tcL9qysSoMiakhZeNfru3Y1GUKY4c52tjRUVYaleFi5mrK/eEBKb853Q83XVKO72
        9+IypbOPFBapNhbG/Idqwp6MXwYcuXlwz/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LFKjwLgY669L for <linux-kernel@vger.kernel.org>;
        Fri, 12 Aug 2022 08:41:54 -0700 (PDT)
Received: from [10.225.89.57] (cnd1221sqt.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M47Fs6y6Mz1RtVk;
        Fri, 12 Aug 2022 08:41:53 -0700 (PDT)
Message-ID: <4642848c-a386-d6a0-6255-8b16800e0548@opensource.wdc.com>
Date:   Fri, 12 Aug 2022 08:41:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Oliver Sang <oliver.sang@intel.com>
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
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/12 4:13, John Garry wrote:
> On 12/08/2022 06:01, Oliver Sang wrote:
>> hi, Damien Le Moal,
>>
>> On Tue, Aug 09, 2022 at 07:55:53AM -0700, Damien Le Moal wrote:
>>> On 2022/08/09 2:58, John Garry wrote:
>>>> On 08/08/2022 15:52, Damien Le Moal wrote:
>>>>> On 2022/08/05 1:05, kernel test robot wrote:
>>>>>>
>>>>>>
>>>>>> Greeting,
>>>>>>
>>>>>> FYI, we noticed a -15.0% regression of stress-ng.copy-file.ops_per=
_sec due to commit:
>>>>>>
>>>>>>
>>>>>> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: libata-scs=
i: cap ata_device->max_sectors according to shost->max_sectors")
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git m=
aster
>>>>>>
>>>>>> in testcase: stress-ng
>>>>>> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
>>>>>> with following parameters:
>>>>>>
>>>>>> 	nr_threads: 10%
>>>>>> 	disk: 1HDD
>>>>>> 	testtime: 60s
>>>>>> 	fs: f2fs
>>>>>> 	class: filesystem
>>>>>> 	test: copy-file
>>>>>> 	cpufreq_governor: performance
>>>>>> 	ucode: 0xb000280
>>>>>
>>>>> Without knowing what the device adapter is, hard to say where the p=
roblem is. I
>>>>> suspect that with the patch applied, we may be ending up with a sma=
ll default
>>>>> max_sectors value, causing overhead due to more commands than neces=
sary.
>>>>>
>>>>> Will check what I see with my test rig.
>>>>
>>>> As far as I can see, this patch should not make a difference unless =
the
>>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>>>
>>> That is my hunch too, hence my question about which host driver is be=
ing used
>>> for this test... That is not apparent from the problem report.
>>
>> we noticed the commit is already in mainline now, and in our tests, th=
ere is
>> still similar regression and also on other platforms.
>> could you guide us how to check "which host driver is being used for t=
his
>> test"? hope to supply some useful information.
>>
>=20
> For me, a complete kernel log may help.

I had a look yesterday with my test rig. I did not see any difference in =
the
default max_sectors_kb values for various drives between 5.18 and 5.19 (c=
urrent
linus tree). The test machine has 2 AHCI adapters: Intel and Marvell. Bot=
h use
the regular AHCI driver. I have another rig with different ATA adapters b=
ut it
is powered down and I am traveling... So cannot test that right now.

>=20
>>>
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> If you fix the issue, kindly add following tag
>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>>
>>>>>>
>>>>>> Details are as below:
>>>>>> ------------------------------------------------------------------=
-------------------------------->
>>>>>>
>>>>>>
>>>>>> To reproduce:
>>>>>>
>>>>>>           git clone https://github.com/intel/lkp-tests.git
>>>>>>           cd lkp-tests
>>>>>>           sudo bin/lkp install job.yaml           # job file is at=
tached in this email
>>>>>>           bin/lkp split-job --compatible job.yaml # generate the y=
aml file for lkp run
>>>>>>           sudo bin/lkp run generated-yaml-file
>>>>>>
>>>>>>           # if come across any failure that blocks the test,
>>>>>>           # please remove ~/.lkp and /lkp dir to run from a clean =
state.
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/=
tbox_group/test/testcase/testtime/ucode:
>>>>>>     filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/de=
bian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/copy-file/stress-ng/60s/0xb000=
280
>>>>>>
>>>>>> commit:
>>>>>>     4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors a=
ccording to DMA optimal limit")
>>>>>>     0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors acc=
ording to shost->max_sectors")
>>>>>>
>>>>>> 4cbfca5f7750520f 0568e6122574dcc1aded2979cd0
>>>>>> ---------------- ---------------------------
>>>>>>            %stddev     %change         %stddev
>>>>>>                \          |                \
>>>>>>         1627           -14.9%       1385        stress-ng.copy-fil=
e.ops
>>>>>>        27.01           -15.0%      22.96        stress-ng.copy-fil=
e.ops_per_sec
>>>>>>      8935079           -11.9%    7870629        stress-ng.time.fil=
e_system_outputs
>>>>>>        14.88 =C2=B1  5%     -31.8%      10.14 =C2=B1  3%  stress-n=
g.time.percent_of_cpu_this_job_got
>>>>>>        50912           -14.7%      43413        vmstat.io.bo
>>>>>>        93.78            +1.4%      95.10        iostat.cpu.idle
>>>>>>         3.89           -31.6%       2.66        iostat.cpu.iowait
>>>>>>         4.01            -1.3        2.74        mpstat.cpu.all.iow=
ait%
>>>>>>         0.23 =C2=B1  9%      -0.1        0.17 =C2=B1 11%  mpstat.c=
pu.all.sys%
>>>>>>         1.66 =C2=B1 37%      -1.2        0.51 =C2=B1 55%  perf-pro=
file.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.f2fs_buffer=
ed_write_iter.f2fs_file_write_iter.do_iter_readv_writev
>>>>>>         1.66 =C2=B1 37%      -1.1        0.59 =C2=B1 25%  perf-pro=
file.children.cycles-pp.f2fs_write_end
>>>>>>         1.51 =C2=B1 40%      -1.1        0.45 =C2=B1 26%  perf-pro=
file.children.cycles-pp.f2fs_dirty_data_folio
>>>>>>         1.21 =C2=B1 49%      -1.0        0.23 =C2=B1 33%  perf-pro=
file.children.cycles-pp.f2fs_update_dirty_folio
>>>>>>         0.88 =C2=B1 56%      -0.8        0.04 =C2=B1111%  perf-pro=
file.children.cycles-pp.native_queued_spin_lock_slowpath
>>>>>>         0.14 =C2=B1 26%      +0.1        0.25 =C2=B1 28%  perf-pro=
file.children.cycles-pp.page_cache_ra_unbounded
>>>>>>         0.88 =C2=B1 56%      -0.8        0.04 =C2=B1112%  perf-pro=
file.self.cycles-pp.native_queued_spin_lock_slowpath
>>>>>>      3164876 =C2=B1  9%     -20.2%    2524713 =C2=B1  7%  perf-sta=
t.i.cache-misses
>>>>>>    4.087e+08            -4.6%  3.899e+08        perf-stat.i.dTLB-l=
oads
>>>>>>       313050 =C2=B1 10%     -18.4%     255410 =C2=B1  6%  perf-sta=
t.i.node-loads
>>>>>>       972573 =C2=B1  9%     -16.4%     812873 =C2=B1  6%  perf-sta=
t.i.node-stores
>>>>>>      3114748 =C2=B1  9%     -20.2%    2484807 =C2=B1  7%  perf-sta=
t.ps.cache-misses
>>>>>>    4.022e+08            -4.6%  3.837e+08        perf-stat.ps.dTLB-=
loads
>>>>>>       308178 =C2=B1 10%     -18.4%     251418 =C2=B1  6%  perf-sta=
t.ps.node-loads
>>>>>>       956996 =C2=B1  9%     -16.4%     799948 =C2=B1  6%  perf-sta=
t.ps.node-stores
>>>>>>       358486            -8.3%     328694        proc-vmstat.nr_act=
ive_file
>>>>>>      1121620           -11.9%     987816        proc-vmstat.nr_dir=
tied
>>>>>>       179906            -6.7%     167912        proc-vmstat.nr_dir=
ty
>>>>>>      1151201            -1.7%    1131322        proc-vmstat.nr_fil=
e_pages
>>>>>>       100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.n=
r_inactive_file
>>>>>>       846362           -14.6%     722471        proc-vmstat.nr_wri=
tten
>>>>>>       358486            -8.3%     328694        proc-vmstat.nr_zon=
e_active_file
>>>>>>       100181            +9.9%     110078 =C2=B1  2%  proc-vmstat.n=
r_zone_inactive_file
>>>>>>       180668            -6.8%     168456        proc-vmstat.nr_zon=
e_write_pending
>>>>>>       556469            -3.5%     536985        proc-vmstat.pgacti=
vate
>>>>>>      3385454           -14.6%    2889953        proc-vmstat.pgpgou=
t
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Disclaimer:
>>>>>> Results have been estimated based on internal Intel analysis and a=
re provided
>>>>>> for informational purposes only. Any difference in system hardware=
 or software
>>>>>> design or configuration may affect actual performance.
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>> --=20
>>> Damien Le Moal
>>> Western Digital Research
>> .
>=20


--=20
Damien Le Moal
Western Digital Research
