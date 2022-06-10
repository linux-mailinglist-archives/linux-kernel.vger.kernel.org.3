Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519505461D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiFJJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348877AbiFJJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:21:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA517EF4E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CAD5B83309
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20543C3411C;
        Fri, 10 Jun 2022 09:19:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YlJTWccV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654852773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0ZlcEzOmh/ydalvLnOpLOlkx/qyF5DNIPEx1qZBrPs=;
        b=YlJTWccV31WUh+THqnnmoQsWbfRYTbMmPYXb59YQmr/IYHluQ1m4VxpETT6L/UXL5ve3Sf
        7WH54gysPMpRLkofMS7VZm9bhmDetT/hxJ0DSE+INaNVhN0iK4o2KrCDcP15f7L41De/Zx
        8L7Gz0btKrczHnmBHZ43tHLjukR9pAY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 06324467 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 10 Jun 2022 09:19:33 +0000 (UTC)
Date:   Fri, 10 Jun 2022 11:19:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "R, Monish Kumar" <monish.kumar.r@intel.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <YqMMo2Dv9SZRtR7B@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220610061449.GD24331@lst.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jun 10, 2022 at 08:14:49AM +0200, Christoph Hellwig wrote:
> That leaves us with two plausible theories:
> 
>  - the problems could be due to an earlier firmware version or
>    ASIC stepping
>  - the problems are due to the thunderbolt attachment

Right, that seems like the set of variance we're dealing with. If it's a
firmware version issue, then we revert because people can update? Or can
we quirk firmware version numbers too? If it's ASIC stepping, I guess we
need to quirk that. And likewise thunderbolt, but that seems more
awkward to quirk around, because afaik, it all just appears as PCIe?

> Monish and Jason, can you please send me the output of nvme id-ctrl
> /dev/nvmeX (where /dev/nvmeX is the actual device number)?

NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x144d
sn        : <redacted>
mn        : Samsung SSD 970 EVO Plus 2TB            
fr        : 2B2QEXM7
rab       : 2
ieee      : 002538
cmic      : 0
mdts      : 9
cntlid    : 0x4
ver       : 0x10300
rtd3r     : 0x30d40
rtd3e     : 0x7a1200
oaes      : 0
ctratt    : 0
rrls      : 0
cntrltype : 0
fguid     : 
crdt1     : 0
crdt2     : 0
crdt3     : 0
nvmsr     : 0
vwci      : 0
mec       : 0
oacs      : 0x17
acl       : 7
aerl      : 3
frmw      : 0x16
lpa       : 0x3
elpe      : 63
npss      : 4
avscc     : 0x1
apsta     : 0x1
wctemp    : 358
cctemp    : 358
mtfa      : 0
hmpre     : 0
hmmin     : 0
tnvmcap   : 2000398934016
unvmcap   : 0
rpmbs     : 0
edstt     : 35
dsto      : 0
fwug      : 0
kas       : 0
hctma     : 0x1
mntmt     : 356
mxtmt     : 358
sanicap   : 0
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
domainid  : 0
megcap    : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 0
nn        : 1
oncs      : 0x5f
fuses     : 0
fna       : 0x5
vwc       : 0x1
awun      : 1023
awupf     : 0
icsvscc     : 1
nwpc      : 0
acwu      : 0
ocfs      : 0
sgls      : 0
mnan      : 0
maxdna    : 0
maxcna    : 0
subnqn    : 
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
fcatt     : 0
msdbd     : 0
ofcs      : 0
ps    0 : mp:7.50W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:5.90W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:3.60W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0700W non-operational enlat:210 exlat:1200 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0050W non-operational enlat:2000 exlat:8000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

Jason
