Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F1554E08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352008AbiFVO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbiFVO4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:56:31 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0CD39817
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:56:27 -0700 (PDT)
X-ASG-Debug-ID: 1655909785-1cf43917f346d860001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id gqdzg8HCWptO8LrT; Wed, 22 Jun 2022 10:56:25 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=Glz2SHfgDoOC7wQckZgSnCry+YrW4wGedWsuLaQjkOQ=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=gqGMlqPoNj258oTYCiIT
        V7zVbAuOElVNATUR/KgS42E3FbyiQ2Epsy/jaS2lrM9bn9cdGpXVUq2cEzEpFRHsUcTJX9koiuNai
        zT2YdNUv63Kx0ot7ATMcBOuNuxtM+i9Rqc0xL3Ler2xQxD+FBrp5gEffAQRbixcACYRoHkng2Y=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11946013; Wed, 22 Jun 2022 10:56:25 -0400
Message-ID: <d41671b4-8d29-b940-da37-b8dbe81f4d72@cybernetics.com>
Date:   Wed, 22 Jun 2022 10:56:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [EXT] Re: [REGRESSION] qla2xxx: tape drive not removed after
 unplug FC cable
Content-Language: en-US
X-ASG-Orig-Subj: Re: [EXT] Re: [REGRESSION] qla2xxx: tape drive not removed after
 unplug FC cable
To:     Arun Easi <aeasi@marvell.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
 <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
 <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
 <alpine.LRH.2.21.9999.2206211156470.4730@mvluser05.qlc.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <alpine.LRH.2.21.9999.2206211156470.4730@mvluser05.qlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1655909785
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 23625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 18:05, Arun Easi wrote:
> Thanks for the info. Just to reiterate, you've reported two issues (though 
> this log was showing only 1 of them).
>
> Issue 1 - Tape device never disappears when removed
> Issue 2 - When a direct connected tape 1 was replaced with tape 2, tape 2 
>           was not discovered.
>
> For Issue-2, please try the attached patch. This may not be the final fix, 
> but wanted to check if that would fix the issue for you.
>
> For Issue-1, the behavior was intentional, though that behavior needs 
> refinement. These tape drives support something called FC sequence level 
> error recovery (added in FCP-2), which can make tape I/Os survive even 
> across a short cable pull. This is not a simple retry of the I/O, rather a 
> retry done at the FC sequence level that gives the IO a better chance of
> revival. In other words, the said patch that caused regression, while 
> introduces an incorrect reporting of the state of the device, makes backup 
> more resilient.
>
> Now, onto the behavior when device state is reported immediately. What we 
> have observed, at least with one tape drive from a major vendor, is that, 
> across a device loss and device back case with both the events reported to 
> upper layers, the backup operation was getting failed. This is due to a 
> REPORT LUNS command being issued during device reappearance reporting 
> (fc_remote_port_add -> SCSI scan), which the tape drive was not expecting 
> and caused the backup to fail.
>
> I know that some tape drives do not support multiple commands to it at the 
> same time, but not sure if that is still the norm these days.
>
> So, perhaps one way to make the behavior better, is to either report the 
> disappearing device a bit delayed or have intelligence added in SCSI scan 
> to detect ongoing tape IO operations and delay/avoid the REPORT LUNs. 
> Former is a more contained (in the LLD) fix.
>
> Regards,
> -Arun

Your patch does fix Issue-2 for me.  For Issue-1, it would be fine with
me if qla2xxx reported device removal to the upper level a bit delayed,
as you said.

Below is a log of the test for Issue-2 with your patch applied with
kernel 5.18.2:

modprobe qla2xxx ql2xextended_error_logging=1

Jun 22 14:08:23 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.02.07.400-k-debug.
Jun 22 14:08:23 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-011c: : MSI-X vector count: 32.
Jun 22 14:08:23 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-001d: : Found an ISP2031 irq 37 iobase 0x00000000d7dfad2d.
Jun 22 14:08:23 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00c6:6: MSI-X: Using 26 vectors
Jun 22 14:08:23 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-0075:6: ZIO mode 6 enabled; timer delay (200 us).
Jun 22 14:08:23 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-ffff:6: FC4 priority set to NVMe
Jun 22 14:08:24 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-507b:6: SFP detect: Short-Range SFP  (nvr=0 ll=40 lr=0 lrd=0).
Jun 22 14:08:26 tony13 kern.info kernel: scsi host6: qla2xxx
Jun 22 14:08:26 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4000:6: DPC handler sleeping.
Jun 22 14:08:27 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-400f:6: Loop resync scheduled.
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00fb:6: QLogic QLE2672 - QLE2672 QLogic 2-port 16Gb Fibre Channel Adapter.
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00fc:6: ISP2031: PCIe (8.0GT/s x8) @ 0000:83:00.0 hdma- host#=6 fw=8.07.12 (d0d5).
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-011c: : MSI-X vector count: 32.
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:00:00.0]-001d: : Found an ISP2031 irq 135 iobase 0x0000000083e02c30.
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00c6:7: MSI-X: Using 26 vectors
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-0075:7: ZIO mode 6 enabled; timer delay (200 us).
Jun 22 14:08:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: FC4 priority set to NVMe
Jun 22 14:08:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-507b:7: SFP detect: Short-Range SFP  (nvr=0 ll=40 lr=0 lrd=0).
Jun 22 14:08:34 tony13 kern.info kernel: scsi host7: qla2xxx
Jun 22 14:08:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
Jun 22 14:08:36 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
Jun 22 14:08:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00fb:7: QLogic QLE2672 - QLE2672 QLogic 2-port 16Gb Fibre Channel Adapter.
Jun 22 14:08:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00fc:7: ISP2031: PCIe (8.0GT/s x8) @ 0000:83:00.1 hdma- host#=7 fw=8.07.12 (d0d5).
Jun 22 14:08:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-8038:6: Cable is unplugged...
Jun 22 14:08:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-803a:6: fw_state=4 (7, 141, 0, 800 0) curr time=10000dd24.
Jun 22 14:08:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-206c:6: qla2x00_loop_resync *** FAILED ***.
Jun 22 14:08:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4010:6: Loop resync end.
Jun 22 14:08:47 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4000:6: DPC handler sleeping.
Jun 22 14:08:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8038:7: Cable is unplugged...
Jun 22 14:08:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=4 (7, 141, 0, 800 0) curr time=10000e075.
Jun 22 14:08:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206c:7: qla2x00_loop_resync *** FAILED ***.
Jun 22 14:08:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
Jun 22 14:08:56 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.

Plug in cable to tape drive A

Jun 22 14:09:32 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5009:7: LIP occurred (0).
Jun 22 14:09:32 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b7:7: Format 0 : Number of VPs setup 254, number of VPs acquired 1.
Jun 22 14:09:32 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b8:7: Primary port id 0000ef.
Jun 22 14:09:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
Jun 22 14:09:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5012:7: Port database changed ffff 0006 0000.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8037:7: F/W Ready - OK.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=3 (7, 141, 0, 800 0) curr time=10000efb0.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-200b:7: HBA in NL topology.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2014:7: Configure loop -- dpc flags = 0x112e0.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2011:7: Entries in ID list (1).
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d8:7: qla24xx_fcport_handle_login 50:00:e1:11:c5:27:f0:70 DS 0 LS 7 P 0 fl 0 confl 0000000000000000 rscn 0|0 login 0 lid 0 scan 2 fc4type 0
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-307b:7: qla_chk_n2n_b4_login 50:00:e1:11:c5:27:f0:70 DS 0 LS 7 lid 0 retries=30
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20bf:7: qla_chk_n2n_b4_login 1628 50:00:e1:11:c5:27:f0:70 post login
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2069:7: LOOP READY.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206b:7: qla2x00_configure_loop: exiting normally. local port wwpn 2100000e1e2227a1 id 0000ef)
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: DELETED to LOGIN_PEND - portid=000026.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2072:7: Async-login - 50:00:e1:11:c5:27:f0:70 hdl=2, loopid=0 portid=000026 retries=29 .
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5036:7: Async-login complete: handle=2 pid=000026 wwpn=50:00:e1:11:c5:27:f0:70 iop0=312
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dd:7: qla2x00_async_login_sp_done 50:00:e1:11:c5:27:f0:70 res 0 
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: qla24xx_handle_plogi_done_event 50:00:e1:11:c5:27:f0:70 DS 3 LS 7 rc 0 login 0|0 rscn 0|0 data 4000|0 iop 0|0
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ea:7: qla24xx_handle_plogi_done_event 2232 50:00:e1:11:c5:27:f0:70 LoopID 0x0 in use with 000026. post gpdb
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: LOGIN_PEND to GPDB - portid=000026.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dc:7: Async-gpdb 50:00:e1:11:c5:27:f0:70 hndl 0 opt 0
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20db:7: Async done-gpdb res 0, WWPN 50:00:e1:11:c5:27:f0:70 mb[1]=0 mb[2]=ffd3 
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d2:7: qla24xx_handle_gpdb_event 50:00:e1:11:c5:27:f0:70 DS 5 LS 6 fc4_type 0 rc 0
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2062:7: 50:00:e1:11:c5:27:f0:70 SVC Param w3 0312
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: GPDB to UPD_FCPORT - portid=000026.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ef:7: qla2x00_update_fcport 50:00:e1:11:c5:27:f0:70
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: UPD_FCPORT to UPD_FCPORT - portid=000026.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from UNCONFIGURED to ONLINE - portid=000026.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ee:7: qla2x00_reg_remote_port: 5000e111c527f070. rport 7:0:0 (00000000380d4127) is tgt mode
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: UPD_FCPORT to LOGIN_COMPLETE - portid=000026.
Jun 22 14:09:35 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-911e:7: qla_register_fcport_fn rscn gen 0/0 next DS 0
Jun 22 14:09:35 tony13 kern.notice kernel: scsi 7:0:0:0: Sequential-Access IBM      ULTRIUM-HH8      K4K1 PQ: 0 ANSI: 6
Jun 22 14:09:35 tony13 kern.notice kernel: st 7:0:0:0: Attached scsi tape st0
Jun 22 14:09:35 tony13 kern.info kernel: st 7:0:0:0: st0: try direct i/o: yes (alignment 8 B)

cat /proc/scsi/scsi

Attached devices:
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
  Type:   Sequential-Access                ANSI  SCSI revision: 06

COMMENT: Tape drive shows up as expected after cable plugged in.

Unplug cable

Jun 22 14:10:54 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
Jun 22 14:10:54 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost

sleep 120

cat /proc/scsi/scsi

Attached devices:
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
  Type:   Sequential-Access                ANSI  SCSI revision: 06

COMMENT: Tape drive does not disappear after cable unplugged.

Plug in cable to tape drive B

Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5009:7: LIP occurred (0).
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b7:7: Format 0 : Number of VPs setup 254, number of VPs acquired 1.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b8:7: Primary port id 0000ef.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5010:7: Port logout 0000 0007 0300.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-508a:7: Marking port lost loopid=0000 portid=000026.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: LOGIN_COMPLETE to DELETE_PEND - portid=000026.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-210a:7: qlt_unreg_sess sess 00000000fd4cb6a1 for deletion 50:00:e1:11:c5:27:f0:70
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: DELETE_PEND to DELETE_PEND - portid=000026.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-f084:7: qlt_free_session_done: se_sess 0000000000000000 / sess 00000000fd4cb6a1 from port 50:00:e1:11:c5:27:f0:70 loop_id 0x00 s_id 00:00:26 logout 0 keep 1 els_logo 0
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from ONLINE to LOST - portid=000026.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2109:7: qla2x00_schedule_rport_del 5000e111c527f070. rport 00000000380d4127 roles 1
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5012:7: Port database changed ffff 0006 0000.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:70 disc_state transition: DELETE_PEND to DELETED - portid=000026.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-f001:7: Unregistration of sess 00000000fd4cb6a1 50:00:e1:11:c5:27:f0:70 finished fcp_cnt 0
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8037:7: F/W Ready - OK.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=3 (7, 141, 0, 4 0) curr time=100016448.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-200b:7: HBA in NL topology.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2014:7: Configure loop -- dpc flags = 0x1260.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2011:7: Entries in ID list (0).
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-d050:7: Link reinitialized
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206a:7: qla2x00_configure_loop *** FAILED ***.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500c:7: LIP reset occurred (f7f7).
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5009:7: LIP occurred (f7f7).
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b7:7: Format 0 : Number of VPs setup 254, number of VPs acquired 1.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-10b8:7: Primary port id 0000ef.
Jun 22 14:14:33 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5012:7: Port database changed ffff 0006 0000.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400b:7: Reset marker scheduled.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400c:7: Reset marker end.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-400f:7: Loop resync scheduled.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-8037:7: F/W Ready - OK.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-803a:7: fw_state=3 (7, 141, 0, 4 0) curr time=1000164b0.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-200b:7: HBA in NL topology.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2014:7: Configure loop -- dpc flags = 0x1260.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2011:7: Entries in ID list (1).
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d8:7: qla24xx_fcport_handle_login 50:00:e1:11:c5:27:f0:5c DS 0 LS 7 P 0 fl 0 confl 0000000000000000 rscn 0|0 login 0 lid 0 scan 2 fc4type 0
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-307b:7: qla_chk_n2n_b4_login 50:00:e1:11:c5:27:f0:5c DS 0 LS 7 lid 0 retries=30
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20bf:7: qla_chk_n2n_b4_login 1628 50:00:e1:11:c5:27:f0:5c post login
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2069:7: LOOP READY.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-206b:7: qla2x00_configure_loop: exiting normally. local port wwpn 2100000e1e2227a1 id 0000ef)
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4010:7: Loop resync end.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4000:7: DPC handler sleeping.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:5c disc_state transition: DELETED to LOGIN_PEND - portid=000026.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2072:7: Async-login - 50:00:e1:11:c5:27:f0:5c hdl=4, loopid=0 portid=000026 retries=29 .
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-5036:7: Async-login complete: handle=4 pid=000026 wwpn=50:00:e1:11:c5:27:f0:5c iop0=312
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dd:7: qla2x00_async_login_sp_done 50:00:e1:11:c5:27:f0:5c res 0 
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-ffff:7: qla24xx_handle_plogi_done_event 50:00:e1:11:c5:27:f0:5c DS 3 LS 7 rc 0 login 0|0 rscn 0|0 data 4000|0 iop 0|0
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ea:7: qla24xx_handle_plogi_done_event 2232 50:00:e1:11:c5:27:f0:5c LoopID 0x0 in use with 000026. post gpdb
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:5c disc_state transition: LOGIN_PEND to GPDB - portid=000026.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20dc:7: Async-gpdb 50:00:e1:11:c5:27:f0:5c hndl 0 opt 0
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20db:7: Async done-gpdb res 0, WWPN 50:00:e1:11:c5:27:f0:5c mb[1]=0 mb[2]=ffd3 
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20d2:7: qla24xx_handle_gpdb_event 50:00:e1:11:c5:27:f0:5c DS 5 LS 6 fc4_type 0 rc 0
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2062:7: 50:00:e1:11:c5:27:f0:5c SVC Param w3 0312
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:5c disc_state transition: GPDB to UPD_FCPORT - portid=000026.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ef:7: qla2x00_update_fcport 50:00:e1:11:c5:27:f0:5c
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:5c disc_state transition: UPD_FCPORT to UPD_FCPORT - portid=000026.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:5c state transitioned from UNCONFIGURED to ONLINE - portid=000026.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20ee:7: qla2x00_reg_remote_port: 5000e111c527f05c. rport 7:0:1 (0000000091a61914) is tgt mode
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-2134:7: FCPort 50:00:e1:11:c5:27:f0:5c disc_state transition: UPD_FCPORT to LOGIN_COMPLETE - portid=000026.
Jun 22 14:14:34 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-911e:7: qla_register_fcport_fn rscn gen 0/0 next DS 0
Jun 22 14:14:34 tony13 kern.notice kernel: scsi 7:0:1:0: Sequential-Access IBM      ULTRIUM-HH9      NCA1 PQ: 0 ANSI: 6
Jun 22 14:14:34 tony13 kern.notice kernel: st 7:0:1:0: Attached scsi tape st1
Jun 22 14:14:34 tony13 kern.info kernel: st 7:0:1:0: st1: try direct i/o: yes (alignment 8 B)
Jun 22 14:14:34 tony13 kern.notice kernel: scsi 7:0:1:1: Medium Changer    CYBERNET CY-LTOLIB        1.40 PQ: 0 ANSI: 5

cat /proc/scsi/scsi

Attached devices:
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
  Type:   Sequential-Access                ANSI  SCSI revision: 06
Host: scsi7 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH9      Rev: NCA1
  Type:   Sequential-Access                ANSI  SCSI revision: 06
Host: scsi7 Channel: 00 Id: 01 Lun: 01
  Vendor: CYBERNET Model: CY-LTOLIB        Rev: 1.40
  Type:   Medium Changer                   ANSI  SCSI revision: 05

COMMENT: Tape drive B shows up as expected; tape drive A disappears 30 seconds later:

Jun 22 14:15:03 tony13 kern.err kernel:  rport-7:0-0: blocked FC remote port time out: removing target and saving binding
Jun 22 14:15:03 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:70 state transitioned from LOST to DEAD - portid=000026.

cat /proc/scsi/scsi

Attached devices:
Host: scsi7 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH9      Rev: NCA1
  Type:   Sequential-Access                ANSI  SCSI revision: 06
Host: scsi7 Channel: 00 Id: 01 Lun: 01
  Vendor: CYBERNET Model: CY-LTOLIB        Rev: 1.40
  Type:   Medium Changer                   ANSI  SCSI revision: 05

Unplug cable

Jun 22 14:15:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
Jun 22 14:15:31 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost

cat /proc/scsi/scsi

Attached devices:
Host: scsi7 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: ULTRIUM-HH9      Rev: NCA1
  Type:   Sequential-Access                ANSI  SCSI revision: 06
Host: scsi7 Channel: 00 Id: 01 Lun: 01
  Vendor: CYBERNET Model: CY-LTOLIB        Rev: 1.40
  Type:   Medium Changer                   ANSI  SCSI revision: 05

COMMENT: Tape drive does not disappear after cable unplugged.

rmmod qla2xxx

Jun 22 14:16:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
Jun 22 14:16:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-b079:7: Removing driver
Jun 22 14:16:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-00af:7: Performing ISP error recovery - ha=0000000070375427.
Jun 22 14:16:28 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-20f1:7: Mark all dev lost
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-211a:7: Delaying session delete for FCP2 flags 0x4 port_type = 0x4 port_id=000026 50
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-4011:7: DPC handler exiting.
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.1]-207d:7: FCPort 50:00:e1:11:c5:27:f0:5c state transitioned from ONLINE to DEAD - portid=000026.
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-b079:6: Removing driver
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-00af:6: Performing ISP error recovery - ha=000000006f17f9d2.
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-20f1:6: Mark all dev lost
Jun 22 14:16:39 tony13 kern.warn kernel: qla2xxx [0000:83:00.0]-4011:6: DPC handler exiting.

Tony Battersby
Cybernetics

