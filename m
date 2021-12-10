Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047A246F9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhLJDdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:33:49 -0500
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com ([104.47.58.102]:13942
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231314AbhLJDdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:33:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAUY65FlO4r2PWV0BTCTel0lvluNwxPuKzQUELKfmcCM/pDHenLhIYNa/NQ2YVCCn/eC/7ShkuCyFqS6HjaQ4Qmh7aY2ry5WjvCmUx9fd7L0dtwaAjovaICXkR+i+oSneBYpw1Q3pby3a/0gHTAFoMHUnIH+B6hwM3pIJq828Su6NgpQtvIvu5LBJqJBR+wQmihnra7fxu+MEy/eDlEAJ4iQtOfZkmwiIntgGrGdNBla9g4YzW4NVXP1JWaET/SNXYvcmEvU6KHbfG39BRYAN3k9FOJHTONB8s5PPTG6AJLhHk2otSOIWcjrACfcs6Mc9iQcNWVAEWWymTUQmh81Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrL4AlPVHb1B7qT1OnZcDWq5zWMR/iZionCp0Mb3Uag=;
 b=FNQs6K60W+HIC8xVwABVzoP4uJ3yzHcovP7KHw2prwgq/nIBIiymHoU2MxbwSFCEh0uGMO8dNu9sXC02Rv+sfQlwtlM+/L5mR6hwC/1sSx6pxnY8nUOI8n4A8sDWTkyXdEiHXjF3pmeo6oXyuECobUveEkdkcj7p9BLgH67mRCws7f6BmOPWfBXe69Bl0LejIc1XUn08wJW02vOZngqsqWeUwQ/aBoXbBCzsPZ3uYFfTTUbQQ6KC1cCzXud80pNGzgKa138TNtcRpVNsg15q6p67EpaesYffZDXVy6UBTVKfB2LETynOC7h2Lk2rHgpXe4HO6Fb9NabjT02FkmT5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrL4AlPVHb1B7qT1OnZcDWq5zWMR/iZionCp0Mb3Uag=;
 b=EulQSDF34zIhLVL1FUqrNjeC1See0QCx4YBgkgAhARIWjHfQaG8v4F1vA5u2iSVftuTlHcMKjR9m/Nk3WiOU/5sXrrI/2Vtp0VWW3wakYn9MSXAr+wiszqSAOrVF1LDPCeYY4+6IzcqVnjL+/QtGdzn3XE8PJHvprbmsW4dH0lM=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BY5PR21MB1508.namprd21.prod.outlook.com (2603:10b6:a03:23a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Fri, 10 Dec
 2021 03:30:10 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Fri, 10 Dec 2021
 03:30:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuw==
Date:   Fri, 10 Dec 2021 03:30:09 +0000
Message-ID: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2a80eee-9657-461a-8970-0fd3dfc0ce87;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-10T00:06:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37920df1-4573-4193-db64-08d9bb8d5e9e
x-ms-traffictypediagnostic: BY5PR21MB1508:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB1508E107BBC7903E76F3FD86BF719@BY5PR21MB1508.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZve6rQneQ7X3gIoQyvLvpPbygXsd4iGf36NcniZxBSpu2wQyNbbE9YYyY2GnM2dH/F7dqaGC6o/QxQr3W5tkNkZXTn2IfNA9GHhxbzyW5Dh6C2IeVmHaXm2xZ1X+8IK7Lf1yrYQh5TwmCxLLK0L1CWKPpIjDk6rO7BnEO4zZ7NnqUTW0gKzKFys9/CYQh5jkD2pYWBE3A2c4KqoIUWm3UY0AAtl99KZdiCJG4IbNr3Jv/QPl2M/DPA+626PW1OKXC2lSR/xibIIbMCQg7X+hseQZ4pVmTAhU4QEBJIrmEx0SMxMFEc8DtAApcCxcfFGbsV8kC8TR6raNJvj8Nl53xQUPjc3wo+MvwXuU0O4ula8xOOFo0DiLeuKku4lYsxQW2SIJ2MIPWFYO74hMC/uI7DYemQbhW9Xjk7Fpdhmy7ANkF/s1iOcMwC7VZ9cnLlMqWtnqU/K0LfN1nXR47ItWJDq3pIbXdIGwhh0QUh3IyU/g5s2eG2FL1xzQ1jWX8HLY6DQa16pVj1mSHll8T3LlEKDaN4eWWMCZ6RRprYNVyUeTCT8deT1feLwWwZBvFndZppIOCOBGVesD0ySFyYwKaaceRw4C6wuNb5xr4+TI2Aktwy8LtUS21VyERJ30IE/jtZO3zqemPR3aLWOnn0DP/EHH55Ok+wVBU/b/sDTvEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38070700005)(316002)(86362001)(55016003)(8676002)(4326008)(66446008)(33656002)(66476007)(66556008)(64756008)(71200400001)(2906002)(5660300002)(82950400001)(7696005)(82960400001)(52536014)(83380400001)(26005)(9686003)(122000001)(30864003)(10290500003)(110136005)(54906003)(66946007)(76116006)(8990500004)(6506007)(38100700002)(186003)(508600001)(579004)(559001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: KoJUuIsBPWlhPXeh5cMsteg/RFE0ioZxALnuGG5aiOfiGfaTh/IymXI9rI20gbQQ+tg3iJBTMlID3KNalm2jykqLlz9WZ5EKJU3m1xHW4l12JoXiHCnlEG3do8qdvHrpEpV0V0EJJi3kauCereB0yATc7+SlcVJuS06V0TVLzD1q8oGfwu2lRNSWHMFBRGvRw+/Nm8+6ppNTgBDlbkhPk+u5hu9eqUzeQyNTIsgecq+bMRitzc/LXkJDqaIdY5WKv4pMyPg6SqWN/bJgKDVWu32Qrse8fhLK9md/JcOwPtHuA4LnIv1aeBUyDaVdBJunKLu7ndMN8wljIgD9NMogWSJi3VXbX4c2VjUZMLFSMBCxKmJ8y0kbOdrtpZWVTsRl21vM4+gUQkZKTjarn9ZWleKTIyIJ4g0NW4jmBpgZtk46jSZM45r4ImswShzPL63E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37920df1-4573-4193-db64-08d9bb8d5e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 03:30:09.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45czOEKZugMavZCQIhquw0eWSfIRGnaOcYmp2dXObwG7tnLnz2uSGMf2OJobspdy9u+w62qpukmLHelwJTfsQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1508
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I found a random high CPU utilization issue with some database benchmark
program running on a 192-CPU virtual machine (VM). Originally the issue
was found with RHEL 8.4 and Ubuntu 20.04, and further tests show that the
issue also reproduces with the latest upstream stable kernel v5.15.7, but
*not* with v5.16-rc1. It looks like someone resolved the issue in v5.16-rc1
recently?

Details:
The database benchmark test starts 1000+ processes, but it is not
CPU-intensive. The processes access 24 iSCSI-backed disks (multipath is
used), and here no local disk is used). Normally the overall CPU
utilization of 192 CPUs should be 2~5%, including %user (less than 1%),
%sys (2~5%), and %si (less than 1%) . The iSCSI TCP traffic is not heavy an=
d
the packets-per-second (PPS) rate is not high. By default the "none" I/O
scheduler is used in the test.

The issue is: every 1~2 minutes, there is a >90% CPU utilization spike
that lasts 5~20 seconds, and the system's performance drops
significantly. When the CPU utilization spike is happening, *each* of
the 192 CPUs' %sys goes up to 60+%, and the %si goes up to 30%!
Sometimes if I'm not lucky, the >90% CPU utilization happens all the time.

This is not a NIC driver issue becaue the NIC interrupt rate is low due
to NAPI, and the PPS rate is also low (only about 250K/s) and the network
traffic is also low (typically only 2~5 Gbps. The limit for the VM is
30 Gbps, and the NIC driver itself is able to reach a throughput of
20+Gbps easily, if the database benchmark test is not running).

The NIC driver uses 31 queues by default. When the CPU utilization spike
is happening, if I configure the NIC to use only 1 queue by
"ethtool -L eth0 combined 1", the CPU utilization goes down to normal
immediately, and the network throughput and PPS rate go up; if I use 2
queues, the CPU utilization is also not normal (and it consistently
stays at this high CPU utilization -- see [1]), but is not so high as
the 31-queue case. In the case of [1], the iSCSI TCP packets are
processed on CPU 7 and CPU 30 ("cat /proc/irq/57/smp_affinity_list"
returns "7", and "cat /proc/irq/58/smp_affinity_list" returns "30") on
which the NIC's MSI-X interrupts (IRQ 57 and 58) are bound to. If I
check the hottest functions on CPU 7 and CPU 30, e.g.
by "perf top -C 7 --call-graph dwarf" (see [2]), it looks like the code pat=
h
blk_done_softirq() -> ... -> blk_mq_sched_restart() -> ...
-> kblockd_mod_delayed_work_on() -> ... -> try_to_grab_pending() is
even hotter than the NIC TX/RX handler and the TCP/IP stack! Since the
other 190 CPUs also have high %sys and %si (see [3]), I check
"perf top -C 0 --call-graph dwarf" and find that the same
blk_done_softirq() -> ... -> try_to_grab_pending() code path is very hot.

My feeling is that it looks like the iSCSI hardware queues are experiencing
the transition "not full -> full -> not full -> full -> ... " very frequent=
ly
and the blk-mq softirq handler is called very frequently, trying to submit
new I/O requests? try_to_grab_pending() acquires and releases the pool->loc=
k
spinlock, and I guess there may be a lock contention issue??  If I change
the NIC's second IRQ's affinity from CPU 30 to to CPU 7 as well (i.e. both =
the
NIC queues are handled by the same CPU 7) by=20
" echo 7 > /proc/irq/58/smp_affinity_list", the high CPU utilization issue =
goes
away immediately (i.e. the %sys and %si numbers on each CPU rather than
CPU7 go down immediately to normal, i.e. %sys =3D 1.9%, %si =3D 0.6%);
if I change the second IRQ's affinity back to CPU 30, the high CPU utilizat=
ion
happens again immediately. Any insights into this significant difference wh=
en
blk_done_softirq() runs on 1 CPU vs. on 2 CPUs? Here when both the 2 NIC
IRQs happen on the same CPU, the network throughput and PPS rate are
actually better.

When the high CPU utilization issue is happening, if I change the I/O
scheduler from "noop" to "mq-deadline", basicaly the issue will also go
away immediately (%sys =3D 2.7%, %si =3D 1.4%. This is slightly higher than=
 the
case where "noop" is used and both the 2 NIC IRQs happen on the same CPU).

It's unclear why the issue doesn't reproduce with v5.16-rc1. The kernel
difference from v5.15.7 (the bad one) is huge (1+ million lines of changes)
and a weird file system hang issue (if I use a kernel git commit in between=
, I/O
requests on the iSCSI disks can not complete at all -- see [5]) prevents me
from doing git-bisect. There are about 100 patches related to blk-mq, and
at first glance I have not found anything that can explain why the issue
does not reproduce with v5.16-rc1.

Thanks,
-- Dexuan


[1] The snippet of the "top" command ( v5.15.7 stable kernel; the NIC uses =
2 queues)

top - 01:49:14 up 31 min,  2 users,  load average: 1052.88, 999.40, 706.60
Tasks: 2862 total, 207 running, 2654 sleeping,   1 stopped,   0 zombie
%Cpu(s):  0.1 us, 35.2 sy,  0.0 ni,  1.1 id, 49.6 wa,  0.0 hi, 14.0 si,  0.=
0 st
MiB Mem : 2064232.+total, 2053872.+free,   9031.1 used,   1328.6 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used. 2049269.+avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND
    195 root      20   0       0      0      0 R  92.7   0.0  13:37.47 ksof=
tirqd/30
     57 root      20   0       0      0      0 R  91.4   0.0  14:22.18 ksof=
tirqd/7
  11649 root      20   0   18624   3544   1536 R  70.3   0.0   9:02.73 Gene=
rateIO.Linu
  11654 root      20   0   18624   3544   1536 R  69.8   0.0   9:05.26 Gene=
rateIO.Linu
  11650 root      20   0   18624   3544   1536 R  69.0   0.0   9:00.95 Gene=
rateIO.Linu
  11655 root      20   0   18624   3544   1536 R  68.9   0.0   8:39.59 Gene=
rateIO.Linu
  11652 root      20   0   18624   3544   1536 R  68.8   0.0   8:37.07 Gene=
rateIO.Linu
  11656 root      20   0   18624   3544   1536 R  68.5   0.0   8:40.68 Gene=
rateIO.Linu
  11651 root      20   0   18624   3544   1536 R  68.2   0.0   8:38.72 Gene=
rateIO.Linu
  11653 root      20   0   18624   3544   1536 S  67.5   0.0   8:39.97 Gene=
rateIO.Linu
    869 root      20   0       0      0      0 S  10.2   0.0   1:32.12 ksof=
tirqd/142
    580 root      20   0       0      0      0 R  10.1   0.0   1:28.62 ksof=
tirqd/94
    629 root      20   0       0      0      0 S  10.1   0.0   1:28.80 ksof=
tirqd/102
    436 root      20   0       0      0      0 S  10.0   0.0   1:27.72 ksof=
tirqd/70
    556 root      20   0       0      0      0 S  10.0   0.0   1:29.44 ksof=
tirqd/90
    316 root      20   0       0      0      0 S   9.9   0.0   1:29.45 ksof=
tirqd/50
    592 root      20   0       0      0      0 S   9.9   0.0   1:32.97 ksof=
tirqd/96
    990 root      20   0       0      0      0 R   9.8   0.0   1:29.08 ksof=
tirqd/162
...

[2] "perf top -C 7 --call-graph dwarf -d 30"  (only the first lines of the =
output are shown here)

Samples: 1M of event 'cpu-clock:pppH', 4000 Hz, Event count (approx.): 2463=
56121644 lost: 0/47 drop: 0/0
  Children      Self  Shared Object            Symbol
-   98.01%     0.03%  [kernel]                 [k] __softirqentry_text_star=
t
   - 12.10% __softirqentry_text_start
      - 7.10% blk_done_softirq
         - 7.22% blk_complete_reqs
            - 6.52% dm_softirq_done
               - 6.55% dm_done
                  - 6.52% blk_mq_end_request
                     - 6.53% blk_mq_free_request
                        - 6.49% __blk_mq_free_request
                           - 6.48% blk_mq_sched_restart
                              - 6.46% blk_mq_run_hw_queue
                                 - 6.46% __blk_mq_delay_run_hw_queue
                                    - 7.20% kblockd_mod_delayed_work_on
                                       - 51.73% mod_delayed_work_on
                                            try_to_grab_pending
      - 4.89% net_rx_action
         - 4.90% __napi_poll
            - 3.28% mlx5e_napi_poll
               - 3.03% mlx5e_poll_rx_cq
                  - 3.85% mlx5e_handle_rx_cqe
                     - 2.65% napi_gro_receive
                        - 2.54% dev_gro_receive
                           - 1.78% napi_gro_complete.constprop.0.isra.0
                              - 1.80% netif_receive_skb_list_internal
                                 - 1.82% __netif_receive_skb_list_core
                                    - 1.76% ip_list_rcv
                                       - 1.77% ip_sublist_rcv
                                          - 1.67% ip_sublist_rcv_finish
                                             - 1.70% ip_local_deliver
                                                - 1.61% ip_local_deliver_fi=
nish
                                                   - 1.71% ip_protocol_deli=
ver_rcu
                                                      - 1.81% tcp_v4_rcv
                                                         - 1.63% tcp_v4_do_=
rcv
                                                            - 1.73% tcp_rcv=
_established
                                                               - 0.98% tcp_=
data_ready
                                                                  - 0.97% i=
scsi_sw_tcp_data_ready
                                                                     - 0.99=
% tcp_read_sock
                                                                        - 2=
.00% iscsi_sw_tcp_recv
                                                                           =
- 2.01% iscsi_tcp_recv_skb
                                                                           =
  0.99% memcpy_erms
                     - 1.34% mlx5e_skb_from_cqe_linear
               - 0.86% mlx5e_poll_tx_cq
            - 1.93% napi_gro_flush
               - 1.95% napi_gro_complete.constprop.0.isra.0
                  - 1.95% netif_receive_skb_list_internal
                     - 1.98% __netif_receive_skb_list_core
                        - 1.92% ip_list_rcv
                           - 1.93% ip_sublist_rcv
                              - 1.84% ip_sublist_rcv_finish
                                 - 1.87% ip_local_deliver
                                    - 1.78% ip_local_deliver_finish
                                       - 1.89% ip_protocol_deliver_rcu
                                          - 1.97% tcp_v4_rcv
                                             - 1.82% tcp_v4_do_rcv
                                                - 1.93% tcp_rcv_established
                                                   - 1.10% tcp_data_ready
                                                      - 1.10% iscsi_sw_tcp_=
data_ready
                                                         - 1.12% tcp_read_s=
ock
                                                            - 2.59% iscsi_s=
w_tcp_recv
                                                               - 2.64% iscs=
i_tcp_recv_skb
                                                                    0.78% i=
scsi_tcp_segment_done
                                                                 1.38% memc=
py_erms
+   92.61%     0.01%  [kernel]                 [k] smpboot_thread_fn
+   92.58%     0.01%  [kernel]                 [k] run_ksoftirqd
+   56.55%     0.00%  [kernel]                 [k] blk_done_softirq
+   56.53%     0.02%  [kernel]                 [k] blk_complete_reqs
+   52.56%     0.00%  [kernel]                 [k] __blk_mq_delay_run_hw_qu=
eue
+   52.55%     0.01%  [kernel]                 [k] blk_mq_run_hw_queue
+   52.54%     0.00%  [kernel]                 [k] kblockd_mod_delayed_work=
_on
+   52.54%     0.87%  [kernel]                 [k] mod_delayed_work_on
+   52.10%     0.00%  [kernel]                 [k] dm_softirq_done
-   52.10%     0.01%  [kernel]                 [k] dm_done
   - 6.54% dm_done
      - 6.52% blk_mq_end_request
         - 6.53% blk_mq_free_request
            - 6.49% __blk_mq_free_request
               - 6.48% blk_mq_sched_restart
                  - 6.46% blk_mq_run_hw_queue
                     - 6.46% __blk_mq_delay_run_hw_queue
                        - 7.20% kblockd_mod_delayed_work_on
                           - 51.73% mod_delayed_work_on
                                try_to_grab_pending
+   51.97%     0.06%  [kernel]                 [k] blk_mq_free_request
+   51.88%     0.00%  [kernel]                 [k] blk_mq_end_request
+   51.88%     0.04%  [kernel]                 [k] __blk_mq_free_request
+   51.77%     0.02%  [kernel]                 [k] blk_mq_sched_restart
-   51.67%    51.64%  [kernel]                 [k] try_to_grab_pending
   - 6.34% ret_from_fork
      - kthread
         - 6.06% smpboot_thread_fn
            - 6.05% run_ksoftirqd
               - 48.66% __softirqentry_text_start
                    blk_done_softirq
                    blk_complete_reqs
                    dm_softirq_done
                    dm_done
                    blk_mq_end_request
                    blk_mq_free_request
                    __blk_mq_free_request
                    blk_mq_sched_restart
                    blk_mq_run_hw_queue
                    __blk_mq_delay_run_hw_queue
                    kblockd_mod_delayed_work_on
         - 1.53% worker_thread
            - 1.45% asm_sysvec_hyperv_stimer0
                 sysvec_hyperv_stimer0
                 irq_exit_rcu
                 __softirqentry_text_start
                 blk_done_softirq
                 blk_complete_reqs
                 dm_softirq_done
                 dm_done
                 blk_mq_end_request
                 blk_mq_free_request
                 __blk_mq_free_request
                 blk_mq_sched_restart
                 blk_mq_run_hw_queue
                 __blk_mq_delay_run_hw_queue
                 kblockd_mod_delayed_work_on
                 mod_delayed_work_on
                 try_to_grab_pending
+   40.07%     0.02%  [kernel]                 [k] net_rx_action
+   40.04%     0.01%  [kernel]                 [k] __napi_poll
+   33.42%     0.06%  [kernel]                 [k] netif_receive_skb_list_i=
nternal
+   33.23%     0.05%  [kernel]                 [k] __netif_receive_skb_list=
_core
+   32.96%     0.04%  [kernel]                 [k] ip_list_rcv
+   32.87%     0.05%  [kernel]                 [k] ip_sublist_rcv
+   31.34%     0.05%  [kernel]                 [k] ip_sublist_rcv_finish
+   31.27%     0.06%  [kernel]                 [k] ip_local_deliver
+   30.69%     0.02%  [kernel]                 [k] ip_local_deliver_finish
+   30.66%     0.04%  [kernel]                 [k] ip_protocol_deliver_rcu
+   30.57%     0.26%  [kernel]                 [k] tcp_v4_rcv
+   30.20%     0.03%  [kernel]                 [k] napi_gro_complete.constp=
rop.0.isra.0
+   29.79%     0.03%  [kernel]                 [k] tcp_v4_do_rcv
+   29.68%     0.15%  [kernel]                 [k] tcp_rcv_established
+   25.13%     0.04%  [kernel]                 [k] tcp_data_ready
+   25.05%     0.06%  [kernel]                 [k] iscsi_sw_tcp_data_ready
+   24.94%     0.05%  [kernel]                 [k] tcp_read_sock
+   22.24%     0.02%  [kernel]                 [k] mlx5e_napi_poll
+   21.04%     0.05%  [kernel]                 [k] iscsi_sw_tcp_recv
+   20.26%     0.30%  [kernel]                 [k] mlx5e_poll_rx_cq
+   19.93%     0.18%  [kernel]                 [k] mlx5e_handle_rx_cqe
+   17.35%     0.76%  [kernel]                 [k] iscsi_tcp_recv_skb
+   17.31%     0.07%  [kernel]                 [k] napi_gro_receive
+   16.60%     0.03%  [kernel]                 [k] napi_gro_flush
+   14.88%     0.32%  [kernel]                 [k] dev_gro_receive
+   12.23%     0.00%  [kernel]                 [k] ret_from_fork
+   12.23%     0.00%  [kernel]                 [k] kthread
+   10.17%     0.04%  [kernel]                 [k] iscsi_complete_pdu
+   10.06%     0.23%  [kernel]                 [k] __iscsi_complete_pdu
+    9.33%     0.03%  [kernel]                 [k] iscsi_complete_task
+    8.95%     0.52%  [kernel]                 [k] __iscsi_put_task
+    8.41%     0.03%  [kernel]                 [k] blk_mq_complete_reque


[3]  The first lines of the "top" output are shown here:

top - 02:09:58 up 52 min,  2 users,  load average: 1050.01, 1038.20, 951.19
Tasks: 2862 total,  38 running, 2823 sleeping,   1 stopped,   0 zombie
%Cpu0  :  1.1 us, 37.0 sy,  0.0 ni,  1.3 id, 48.6 wa,  0.0 hi, 12.0 si,  0.=
0 st
%Cpu1  :  1.6 us, 26.1 sy,  0.0 ni,  7.9 id, 59.7 wa,  0.0 hi,  4.7 si,  0.=
0 st
%Cpu2  :  3.7 us, 34.4 sy,  0.0 ni,  1.3 id, 51.0 wa,  0.0 hi,  9.6 si,  0.=
0 st
%Cpu3  :  1.1 us, 24.6 sy,  0.0 ni,  8.0 id, 61.6 wa,  0.0 hi,  4.7 si,  0.=
0 st
%Cpu4  :  0.8 us, 36.0 sy,  0.0 ni,  0.4 id, 53.7 wa,  0.0 hi,  9.1 si,  0.=
0 st
%Cpu5  :  0.1 us, 25.9 sy,  0.0 ni,  5.6 id, 63.8 wa,  0.0 hi,  4.6 si,  0.=
0 st
%Cpu6  :  0.7 us, 25.1 sy,  0.0 ni,  2.8 id, 67.3 wa,  0.0 hi,  4.0 si,  0.=
0 st
%Cpu7  :  0.0 us,  2.1 sy,  0.0 ni,  0.1 id,  0.0 wa,  0.0 hi, 97.8 si,  0.=
0 st
%Cpu8  :  0.3 us, 38.2 sy,  0.0 ni,  0.1 id, 52.0 wa,  0.0 hi,  9.3 si,  0.=
0 st
%Cpu9  :  1.0 us, 28.3 sy,  0.0 ni,  1.4 id, 65.1 wa,  0.0 hi,  4.2 si,  0.=
0 st
%Cpu10 :  0.9 us, 38.2 sy,  0.0 ni,  0.5 id, 49.7 wa,  0.0 hi, 10.6 si,  0.=
0 st
%Cpu11 :  0.0 us, 27.0 sy,  0.0 ni,  2.3 id, 66.0 wa,  0.0 hi,  4.7 si,  0.=
0 st
%Cpu12 :  0.1 us, 37.8 sy,  0.0 ni,  1.2 id, 51.5 wa,  0.0 hi,  9.4 si,  0.=
0 st
%Cpu13 :  0.4 us, 27.3 sy,  0.0 ni,  2.9 id, 64.4 wa,  0.0 hi,  5.0 si,  0.=
0 st
%Cpu14 :  0.3 us, 38.2 sy,  0.0 ni,  0.6 id, 52.3 wa,  0.0 hi,  8.6 si,  0.=
0 st
%Cpu15 :  0.0 us, 26.4 sy,  0.0 ni,  2.9 id, 66.4 wa,  0.0 hi,  4.3 si,  0.=
0 st
%Cpu16 :  0.0 us, 36.3 sy,  0.0 ni,  0.5 id, 54.6 wa,  0.0 hi,  8.6 si,  0.=
0 st
%Cpu17 :  0.1 us, 26.8 sy,  0.0 ni,  5.0 id, 64.1 wa,  0.0 hi,  4.0 si,  0.=
0 st
%Cpu18 :  0.4 us, 38.2 sy,  0.0 ni,  0.8 id, 52.6 wa,  0.0 hi,  8.0 si,  0.=
0 st
%Cpu19 :  0.3 us, 24.5 sy,  0.0 ni,  6.0 id, 63.8 wa,  0.0 hi,  5.4 si,  0.=
0 st
%Cpu20 :  0.9 us, 37.0 sy,  0.0 ni,  0.6 id, 53.1 wa,  0.0 hi,  8.4 si,  0.=
0 st


[4] "perf top -C 0 --call-graph dwarf -d 30"  (only the first lines of the =
output are shown here)

Samples: 63K of event 'cpu-clock:pppH', 4000 Hz, Event count (approx.): 159=
49750000 lost: 77/77 drop: 0/0
  Children      Self  Shared Object                Symbol
-   85.84%     0.01%  [kernel]                     [k] __blk_mq_delay_run_h=
w_queue
   - 85.83% __blk_mq_delay_run_hw_queue
      - 69.75% __blk_mq_run_hw_queue
         - blk_mq_sched_dispatch_requests
            - 68.62% __blk_mq_sched_dispatch_requests
               - 42.70% blk_mq_dispatch_rq_list
                  - 26.92% __blk_mq_delay_run_hw_queue
                     - kblockd_mod_delayed_work_on
                        - 26.91% mod_delayed_work_on
                           - try_to_grab_pending
                              - 4.03% asm_sysvec_call_function_single
                                   sysvec_call_function_single
                                   irq_exit_rcu
                                 - __softirqentry_text_start
                                    - blk_done_softirq
                                      blk_complete_reqs
                                      dm_softirq_done
                                    - dm_done
                                       - 3.81% blk_mq_end_request
                                          - blk_mq_free_request
                                             - __blk_mq_free_request
                                               blk_mq_sched_restart
                                             - blk_mq_run_hw_queue
                                                - 3.81% __blk_mq_delay_run_=
hw_queue
                                                     kblockd_mod_delayed_wo=
rk_on
                                                   - mod_delayed_work_on
                                                        try_to_grab_pending
                  - 15.03% blk_mq_run_hw_queue
                       __blk_mq_delay_run_hw_queue
                       kblockd_mod_delayed_work_on
                     - mod_delayed_work_on
                        - 14.82% try_to_grab_pending
                           - 2.41% asm_sysvec_call_function_single
                                sysvec_call_function_single
                                irq_exit_rcu
                              - __softirqentry_text_start
                                 - blk_done_softirq
                                 - blk_complete_reqs
                                    - dm_softirq_done
                                      dm_done
                                      blk_mq_end_request
                                    - blk_mq_free_request
                                       - 2.30% __blk_mq_free_request
                                          - blk_mq_sched_restart
                                            blk_mq_run_hw_queue
                                            __blk_mq_delay_run_hw_queue
                                            kblockd_mod_delayed_work_on
                                          - mod_delayed_work_on
                                               try_to_grab_pending
                  - 0.72% dm_mq_queue_rq
                       0.60% map_request
               - 25.85% blk_mq_do_dispatch_ctx
                  - 25.36% blk_mq_dispatch_rq_list
                     - 13.48% blk_mq_run_hw_queue
                          __blk_mq_delay_run_hw_queue
                        - kblockd_mod_delayed_work_on
                           - 13.48% mod_delayed_work_on
                              - 13.27% try_to_grab_pending
                                 - 2.21% asm_sysvec_call_function_single
                                      sysvec_call_function_single
                                      irq_exit_rcu
                                    - __softirqentry_text_start
                                       - blk_done_softirq
                                       - blk_complete_reqs
                                          - dm_softirq_done
                                             - 2.09% dm_done
                                                - 2.09% blk_mq_end_request
                                                   - 2.09% blk_mq_free_requ=
est
                                                      - __blk_mq_free_reque=
st
                                                        blk_mq_sched_restar=
t
                                                        blk_mq_run_hw_queue
                                                        __blk_mq_delay_run_=
hw_queue
                                                        kblockd_mod_delayed=
_work_on
                                                      - mod_delayed_work_on
                                                           try_to_grab_pend=
ing
                     - 11.07% __blk_mq_delay_run_hw_queue
                          kblockd_mod_delayed_work_on
                        - mod_delayed_work_on
                           - 11.02% try_to_grab_pending
                              - 1.89% asm_sysvec_call_function_single
                                   sysvec_call_function_single
                                   irq_exit_rcu
                                 - __softirqentry_text_start
                                    - blk_done_softirq
                                      blk_complete_reqs
                                      dm_softirq_done
                                    - dm_done
                                       - 1.81% blk_mq_end_request
                                          - blk_mq_free_request
                                             - 1.81% __blk_mq_free_request
                                                  blk_mq_sched_restart
                                                  blk_mq_run_hw_queue
                                                  __blk_mq_delay_run_hw_que=
ue
                                                  kblockd_mod_delayed_work_=
on
                                                - mod_delayed_work_on
                                                     try_to_grab_pending
                     - 0.77% dm_mq_queue_rq
                          0.59% map_request
            - 1.12% blk_mq_run_hw_queue
                 __blk_mq_delay_run_hw_queue
                 kblockd_mod_delayed_work_on
               - mod_delayed_work_on
                    1.10% try_to_grab_pending
      - 16.09% kblockd_mod_delayed_work_on
         - mod_delayed_work_on
              try_to_grab_pending
+   85.80%     0.01%  [kernel]                     [k] blk_mq_run_hw_queue
+   84.18%     0.00%  [kernel]                     [k] kblockd_mod_delayed_=
work_on
+   84.17%     0.95%  [kernel]                     [k] mod_delayed_work_on
-   83.36%    82.52%  [kernel]                     [k] try_to_grab_pending
   - 54.58% pread64 (inlined
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
      - __x64_sys_pread64
         - 54.57% vfs_read
              new_sync_read
              xfs_file_read_iter
              xfs_file_dio_read
            - iomap_dio_rw
               - 54.55% __iomap_dio_rw
                    blk_finish_plug
                    blk_flush_plug_list
                    blk_mq_flush_plug_list
                  - blk_mq_sched_insert_requests
                     - 53.64% blk_mq_run_hw_queue
                          __blk_mq_delay_run_hw_queue
                          __blk_mq_run_hw_queue
                        - blk_mq_sched_dispatch_requests
                           - 52.67% __blk_mq_sched_dispatch_requests
                              - 32.38% blk_mq_dispatch_rq_list
                                 - 19.96% __blk_mq_delay_run_hw_queue
                                    - kblockd_mod_delayed_work_on
                                       - 19.96% mod_delayed_work_on
                                          - try_to_grab_pending
                                             - 2.49% asm_sysvec_call_functi=
on_single
                                                  sysvec_call_function_sing=
le
                                                  irq_exit_rcu
                                                  __softirqentry_text_start
                                                  blk_done_softirq
                                                  blk_complete_reqs
                                                  dm_softirq_done
                                                  dm_done
                                                  blk_mq_end_request
                                                  blk_mq_free_request
                                                  __blk_mq_free_request
                                                  blk_mq_sched_restart
                                                  blk_mq_run_hw_queue
                                                  __blk_mq_delay_run_hw_que=
ue
                                                  kblockd_mod_delayed_work_=
on
                                                  mod_delayed_work_on
                                                  try_to_grab_pending
                                 - 12.37% blk_mq_run_hw_queue
                                      __blk_mq_delay_run_hw_queue
                                      kblockd_mod_delayed_work_on
                                    - mod_delayed_work_on
                                       - 12.36% try_to_grab_pending
                                          - asm_sysvec_call_function_single
                                            sysvec_call_function_single
                                            irq_exit_rcu
                                            __softirqentry_text_start
                                            blk_done_softirq
                                            blk_complete_reqs
                                            dm_softirq_done
                                            dm_done
                                            blk_mq_end_request
                                            blk_mq_free_request
                                            __blk_mq_free_request
                                            blk_mq_sched_restart
                                            blk_mq_run_hw_queue
                                            __blk_mq_delay_run_hw_queue
                                            kblockd_mod_delayed_work_on
                                            mod_delayed_work_on
                                            try_to_grab_pending
                              - 20.29% blk_mq_do_dispatch_ctx
                                 - 20.02% blk_mq_dispatch_rq_list
                                    - 10.92% blk_mq_run_hw_queue
                                         __blk_mq_delay_run_hw_queue
                                       - kblockd_mod_delayed_work_on
                                          - 10.91% mod_delayed_work_on
                                             - 10.90% try_to_grab_pending
                                                - asm_sysvec_call_function_=
single
                                                  sysvec_call_function_sing=
le
                                                  irq_exit_rcu
                                                  __softirqentry_text_start
                                                  blk_done_softirq
                                                  blk_complete_reqs
                                                  dm_softirq_done
                                                  dm_done
                                                  blk_mq_end_request
                                                  blk_mq_free_request
                                                  __blk_mq_free_request
                                                  blk_mq_sched_restart
                                                  blk_mq_run_hw_queue
                                                  __blk_mq_delay_run_hw_que=
ue
                                                  kblockd_mod_delayed_work_=
on
                                                  mod_delayed_work_on
                                                  try_to_grab_pending
                                    - 9.03% __blk_mq_delay_run_hw_queue
                                         kblockd_mod_delayed_work_on
                                         mod_delayed_work_on
                                       - try_to_grab_pending
                                          - asm_sysvec_call_function_single
                                            sysvec_call_function_single
                                            irq_exit_rcu
                                            __softirqentry_text_start
                                            blk_done_softirq
                                            blk_complete_reqs
                                            dm_softirq_done
                                            dm_done
                                            blk_mq_end_request
                                            blk_mq_free_request
                                            __blk_mq_free_request
                                            blk_mq_sched_restart
                                            blk_mq_run_hw_queue
                                            __blk_mq_delay_run_hw_queue
                                            kblockd_mod_delayed_work_on
                                            mod_delayed_work_on
                                            try_to_grab_pending
                           - 0.97% blk_mq_run_hw_queue
                                __blk_mq_delay_run_hw_queue
                                kblockd_mod_delayed_work_on
                                mod_delayed_work_on
                                try_to_grab_pending
                     - 0.91% blk_mq_try_issue_list_directly
                          blk_mq_request_bypass_insert
                          blk_mq_run_hw_queue
                          __blk_mq_delay_run_hw_queue
                          __blk_mq_run_hw_queue
                        - blk_mq_sched_dispatch_requests
                           - 0.91% __blk_mq_sched_dispatch_requests
                              - 0.83% blk_mq_dispatch_rq_list
                                 - 0.59% __blk_mq_delay_run_hw_queue
                                      kblockd_mod_delayed_work_on
                                      mod_delayed_work_on
                                      try_to_grab_pending
   - 11.05% syscall
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
      - __x64_sys_io_submit
         - 5.77% blk_finish_plug
              blk_flush_plug_list
              blk_mq_flush_plug_list
              blk_mq_sched_insert_requests
              blk_mq_run_hw_queue
              __blk_mq_delay_run_hw_queue
              __blk_mq_run_hw_queue
            - blk_mq_sched_dispatch_requests
               - 5.73% __blk_mq_sched_dispatch_requests
                  - 3.73% blk_mq_dispatch_rq_list
                     - 2.79% __blk_mq_delay_run_hw_queue
                          kblockd_mod_delayed_work_on
                          mod_delayed_work_on
                        - try_to_grab_pending
                           - 0.55% asm_sysvec_call_function_single
                                sysvec_call_function_single
                                irq_exit_rcu
                                __softirqentry_text_start
                                blk_done_softirq
                                blk_complete_reqs
                                dm_softirq_done
                                dm_done
                                blk_mq_end_request
                                blk_mq_free_request
                                __blk_mq_free_request
                                blk_mq_sched_restart
                                blk_mq_run_hw_queue
                               __blk_mq_delay_run_hw_queue
                                kblockd_mod_delayed_work_on
                                mod_delayed_work_on
                                try_to_grab_pending
                     - 0.93% blk_mq_run_hw_queue
                          __blk_mq_delay_run_hw_queue
                          kblockd_mod_delayed_work_on
                          mod_delayed_work_on
                          try_to_grab_pending
                  - 2.00% blk_mq_do_dispatch_ctx
                     - 1.99% blk_mq_dispatch_rq_list
                        - 1.14% blk_mq_run_hw_queue
                             __blk_mq_delay_run_hw_queue
                             kblockd_mod_delayed_work_on
                             mod_delayed_work_on
                             try_to_grab_pending
                        - 0.85% __blk_mq_delay_run_hw_queue
                             kblockd_mod_delayed_work_on
                             mod_delayed_work_on
                             try_to_grab_pending
         - 5.28% io_submit_one
              __io_submit_one.constprop.0
              aio_write
              xfs_file_write_iter
            - xfs_file_dio_write_aligned
               - 5.26% iomap_dio_rw
                  - __iomap_dio_rw
                     - 5.25% blk_finish_plug
                          blk_flush_plug_list
                          blk_mq_flush_plug_list
                        - blk_mq_sched_insert_requests
                           - 5.07% blk_mq_run_hw_queue
                                __blk_mq_delay_run_hw_queue
                                __blk_mq_run_hw_queue
                              - blk_mq_sched_dispatch_requests
                                 - 5.01% __blk_mq_sched_dispatch_requests
                                    - 3.40% blk_mq_dispatch_rq_list
                                       - 2.63% __blk_mq_delay_run_hw_queue
                                            kblockd_mod_delayed_work_on
                                            mod_delayed_work_on
                                          - try_to_grab_pending
                                             - asm_sysvec_call_function_sin=
gle
                                               sysvec_call_function_single
                                               irq_exit_rcu
                                               __softirqentry_text_start
                                               blk_done_softirq
                                               blk_complete_reqs
                                               dm_softirq_done
                                               dm_done
                                               blk_mq_end_request
                                               blk_mq_free_request
                                               __blk_mq_free_request
                                               blk_mq_sched_restart
                                               blk_mq_run_hw_queue
                                               __blk_mq_delay_run_hw_queue
                                               kblockd_mod_delayed_work_on
                                               mod_delayed_work_on
                                               try_to_grab_pending
                                       - 0.76% blk_mq_run_hw_queue
                                            __blk_mq_delay_run_hw_queue
                                            kblockd_mod_delayed_work_on
                                            mod_delayed_work_on
                                            try_to_grab_pending
                                    - 1.62% blk_mq_do_dispatch_ctx
                                       - 1.57% blk_mq_dispatch_rq_list
                                          - 0.79% blk_mq_run_hw_queue
                                               __blk_mq_delay_run_hw_queue
                                               kblockd_mod_delayed_work_on
                                             - mod_delayed_work_on
                                                  0.79% try_to_grab_pending
                                          - 0.77% __blk_mq_delay_run_hw_que=
ue
                                               kblockd_mod_delayed_work_on
                                               mod_delayed_work_on
                                               try_to_grab_pending

[5] the "dmesg" snippet for a kernel between v5.15 and v5.16-rc1 ( iSCSI I/=
O requests can
not complete due to some bug. Is this a known issue?):

[   45.991286] sd 21:0:0:1: [sdbp] Optimal transfer size 1048576 bytes
[   45.991347] sd 25:0:0:2: [sdbr] Write Protect is off
[   45.991349] sd 25:0:0:2: [sdbr] Mode Sense: 85 00 10 08
[   45.991541] sd 23:0:0:1: [sdbq] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   45.991590] sd 22:0:0:2: Attached scsi generic sg71 type 0
[   45.991746] sd 25:0:0:2: [sdbr] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   45.991877] sd 22:0:0:2: [sdbt] 268435456 512-byte logical blocks: (137 =
GB/128 GiB)
[   45.992077] sd 23:0:0:1: [sdbq] Optimal transfer size 1048576 bytes
[   45.992093] sd 22:0:0:2: [sdbt] Write Protect is off
[   45.992094] sd 22:0:0:2: [sdbt] Mode Sense: 85 00 10 08
[   45.992165] sd 25:0:0:2: [sdbr] Optimal transfer size 1048576 bytes
[   45.992394] sd 24:0:0:1: [sdbs] 10737418240 512-byte logical blocks: (5.=
50 TB/5.00 TiB)
[   45.992426] sd 21:0:0:2: Attached scsi generic sg72 type 0
[   45.992533] sd 22:0:0:2: [sdbt] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   45.992691] sd 24:0:0:1: [sdbs] Write Protect is off
[   45.992693] sd 21:0:0:2: [sdbu] 268435456 512-byte logical blocks: (137 =
GB/128 GiB)
[   45.992694] sd 24:0:0:1: [sdbs] Mode Sense: 85 00 10 08
[   45.992995] sd 22:0:0:2: [sdbt] Optimal transfer size 1048576 bytes
[   45.993000] sd 21:0:0:2: [sdbu] Write Protect is off
[   45.993002] sd 21:0:0:2: [sdbu] Mode Sense: 85 00 10 08
[   45.993367] sd 24:0:0:1: [sdbs] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   45.993480] sd 23:0:0:2: Attached scsi generic sg73 type 0
[   45.993603] sd 21:0:0:2: [sdbu] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   45.993993] sd 24:0:0:1: [sdbs] Optimal transfer size 1048576 bytes
[   45.994283] sd 21:0:0:2: [sdbu] Optimal transfer size 1048576 bytes
[   45.994359] sd 23:0:0:2: Power-on or device reset occurred
[   45.995506] sd 24:0:0:2: Attached scsi generic sg74 type 0
[   45.995754] sd 24:0:0:2: Power-on or device reset occurred
[   45.996180] sd 23:0:0:2: [sdbv] 268435456 512-byte logical blocks: (137 =
GB/128 GiB)
[   45.996399] sd 23:0:0:2: [sdbv] Write Protect is off
[   45.996402] sd 23:0:0:2: [sdbv] Mode Sense: 85 00 10 08
[   45.996811] sd 23:0:0:2: [sdbv] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   45.997236] sd 23:0:0:2: [sdbv] Optimal transfer size 1048576 bytes
[   45.998626] sd 24:0:0:2: [sdbw] 268435456 512-byte logical blocks: (137 =
GB/128 GiB)
[   45.998948] sd 24:0:0:2: [sdbw] Write Protect is off
[   45.998949] sd 24:0:0:2: [sdbw] Mode Sense: 85 00 10 08
[   45.999562] sd 24:0:0:2: [sdbw] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   46.000155] sd 24:0:0:2: [sdbw] Optimal transfer size 1048576 bytes
[   46.115711] sd 25:0:0:2: [sdbr] Attached SCSI disk
[   46.116112] sd 21:0:0:0: [sdbj] Attached SCSI disk
[   46.116162] sd 22:0:0:0: [sdbk] Attached SCSI disk
[   46.119829] sd 23:0:0:1: [sdbq] Attached SCSI disk
[   46.120044] sd 21:0:0:2: [sdbu] Attached SCSI disk
[   46.120146] sd 21:0:0:1: [sdbp] Attached SCSI disk
[   46.120234] sd 22:0:0:1: [sdbo] Attached SCSI disk
[   46.127808] sd 23:0:0:2: [sdbv] Attached SCSI disk
[   46.127810] sd 25:0:0:1: [sdbn] Attached SCSI disk
[   46.127941] sd 23:0:0:0: [sdbl] Attached SCSI disk
[   46.128571] sd 24:0:0:1: [sdbs] Attached SCSI disk
[   46.128584] sd 24:0:0:2: [sdbw] Attached SCSI disk
[   46.128703] sd 24:0:0:0: [sdbm] Attached SCSI disk
[   46.131549] sd 25:0:0:0: [sdbi] Attached SCSI disk
[   46.132250] sd 22:0:0:2: [sdbt] Attached SCSI disk
[   51.584107] device-mapper: multipath queue-length: version 0.2.0 loaded
[   54.932029] loop6: detected capacity change from 0 to 8
[   74.779368] hv_balloon: Max. dynamic memory size: 2097152 MB
[  128.762895] sysrq: Show Blocked State
[  128.827260] task:systemd-udevd   state:D stack:    0 pid: 4125 ppid:  24=
02 flags:0x00000000
[  128.827265] Call Trace:
[  128.827269]  __schedule+0xce6/0x13d0
[  128.827281]  ? blk_finish_plug+0x26/0x40
[  128.827288]  ? read_pages+0x1db/0x280
[  128.827295]  schedule+0x4e/0xb0
[  128.827298]  io_schedule+0x3f/0x70
[  128.827301]  wait_on_page_bit_common+0x16e/0x3b0
[  128.827308]  ? filemap_invalidate_unlock_two+0x40/0x40
[  128.827311]  put_and_wait_on_page_locked+0x4f/0x60
[  128.827313]  filemap_get_pages+0x643/0x660
[  128.827317]  filemap_read+0xbb/0x3e0
[  128.827319]  ? refill_obj_stock+0xc8/0x130
[  128.827324]  generic_file_read_iter+0xe5/0x150
[  128.827327]  blkdev_read_iter+0x38/0x70
[  128.827332]  new_sync_read+0x113/0x1a0
[  128.827341]  vfs_read+0xfe/0x1a0
[  128.827345]  ksys_read+0x67/0xe0
[  128.827347]  __x64_sys_read+0x1a/0x20
[  128.827350]  do_syscall_64+0x5c/0xc0
[  128.827356]  ? irqentry_exit_to_user_mode+0x9/0x20
[  128.827359]  ? irqentry_exit+0x19/0x30
[  128.827361]  ? exc_page_fault+0x89/0x160
[  128.827362]  ? asm_exc_page_fault+0x8/0x30
[  128.827367]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  128.827369] RIP: 0033:0x7fee5a814142
[  128.827373] RSP: 002b:00007ffee6f253d8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  128.827375] RAX: ffffffffffffffda RBX: 00005644e54956a8 RCX: 00007fee5a8=
14142
[  128.827376] RDX: 0000000000000400 RSI: 00005644e54956b8 RDI: 00000000000=
00006
[  128.827378] RBP: 00005644e52edec0 R08: 00005644e5495690 R09: 00007fee5a8=
ef200
[  128.827379] R10: 00005644e520c010 R11: 0000000000000246 R12: 00000000000=
00000
[  128.827380] R13: 0000000000000400 R14: 00005644e5495690 R15: 00005644e52=
edf10
[  128.828282] task:systemd-udevd   state:D stack:    0 pid: 5166 ppid:  24=
02 flags:0x00000000
[  128.828284] Call Trace:
[  128.828286]  __schedule+0xce6/0x13d0
[  128.828289]  ? blk_finish_plug+0x26/0x40
[  128.828291]  ? read_pages+0x1db/0x280
[  128.828293]  schedule+0x4e/0xb0
[  128.828296]  io_schedule+0x3f/0x70
[  128.828298]  wait_on_page_bit_common+0x16e/0x3b0
[  128.828301]  ? filemap_invalidate_unlock_two+0x40/0x40
[  128.828304]  put_and_wait_on_page_locked+0x4f/0x60
[  128.828307]  filemap_get_pages+0x643/0x660
[  128.828310]  ? __cond_resched+0x19/0x30
[  128.828313]  filemap_read+0xbb/0x3e0
[  128.828316]  ? sed_ioctl+0x7d1/0x8a0
[  128.828320]  ? cp_new_stat+0x152/0x180
[  128.828324]  generic_file_read_iter+0xe5/0x150
[  128.828326]  ? event_triggers_call+0x5d/0xe0
[  128.828332]  blkdev_read_iter+0x38/0x70
[  128.828334]  new_sync_read+0x113/0x1a0
[  128.828337]  vfs_read+0xfe/0x1a0
[  128.828340]  ksys_read+0x67/0xe0
[  128.828343]  __x64_sys_read+0x1a/0x20
[  128.828345]  do_syscall_64+0x5c/0xc0
[  128.828348]  ? irqentry_exit+0x19/0x30
[  128.828350]  ? exc_page_fault+0x89/0x160
[  128.828351]  ? asm_exc_page_fault+0x8/0x30
[  128.828353]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  128.828355] RIP: 0033:0x7fee5a814142
[  128.828357] RSP: 002b:00007ffee6f25318 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  128.828358] RAX: ffffffffffffffda RBX: 00005644e529ff68 RCX: 00007fee5a8=
14142
[  128.828360] RDX: 0000000000000040 RSI: 00005644e529ff78 RDI: 00000000000=
00006
[  128.828360] RBP: 00005644e52dd960 R08: 00005644e529ff50 R09: 00005644e54=
59b90
[  128.828361] R10: 00005644e520c010 R11: 0000000000000246 R12: 0000001ffff=
f0000
[  128.828362] R13: 0000000000000040 R14: 00005644e529ff50 R15: 00005644e52=
dd9b0
[  128.828430] task:systemd-udevd   state:D stack:    0 pid: 5178 ppid:  24=
02 flags:0x00000000
[  128.828433] Call Trace:
[  128.828434]  __schedule+0xce6/0x13d0
[  128.828437]  ? blk_finish_plug+0x26/0x40
[  128.828439]  ? read_pages+0x1db/0x280
[  128.828441]  schedule+0x4e/0xb0
[  128.828444]  io_schedule+0x3f/0x70
[  128.828446]  wait_on_page_bit_common+0x16e/0x3b0
[  128.828449]  ? filemap_invalidate_unlock_two+0x40/0x40
[  128.828452]  put_and_wait_on_page_locked+0x4f/0x60
[  128.828454]  filemap_get_pages+0x643/0x660
[  128.828458]  filemap_read+0xbb/0x3e0
[  128.828460]  ? page_counter_try_charge+0x34/0xb0
[  128.828466]  ? page_counter_cancel+0x2c/0x70
[  128.828468]  ? page_counter_uncharge+0x22/0x40
[  128.828470]  generic_file_read_iter+0xe5/0x150
[  128.828473]  blkdev_read_iter+0x38/0x70
[  128.828475]  new_sync_read+0x113/0x1a0
[  128.828478]  vfs_read+0xfe/0x1a0
[  128.828480]  ksys_read+0x67/0xe0
[  128.828483]  __x64_sys_read+0x1a/0x20
[  128.828485]  do_syscall_64+0x5c/0xc0
[  128.828488]  ? __audit_syscall_exit+0x233/0x290
[  128.828495]  ? exit_to_user_mode_prepare+0x3d/0x1c0
[  128.828503]  ? syscall_exit_to_user_mode+0x27/0x50
[  128.828505]  ? do_syscall_64+0x69/0xc0
[  128.828508]  ? do_syscall_64+0x69/0xc0
[  128.828510]  ? do_syscall_64+0x69/0xc0
[  128.828512]  ? syscall_exit_to_user_mode+0x27/0x50
[  128.828514]  ? do_syscall_64+0x69/0xc0
[  128.828516]  ? asm_exc_page_fault+0x8/0x30
[  128.828519]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  128.828520] RIP: 0033:0x7fee5a814142
[  128.828522] RSP: 002b:00007ffee6f25318 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  128.828523] RAX: ffffffffffffffda RBX: 00005644e5215ba8 RCX: 00007fee5a8=
14142
[  128.828524] RDX: 0000000000000040 RSI: 00005644e5215bb8 RDI: 00000000000=
00006
[  128.828525] RBP: 00005644e52ab260 R08: 00005644e5215b90 R09: 00005644e52=
b81e0
[  128.828526] R10: 00005644e520c010 R11: 0000000000000246 R12: 000004fffff=
f0000
[  128.828527] R13: 0000000000000040 R14: 00005644e5215b90 R15: 00005644e52=
ab2b0

