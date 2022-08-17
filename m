Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB0597643
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbiHQTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbiHQTJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:09:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C815B33361;
        Wed, 17 Aug 2022 12:09:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8090420753;
        Wed, 17 Aug 2022 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660763348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMXGxDZM1X0roInqXSmFgyBNJ8wdOge6KCuTyZJ4Flk=;
        b=LDII6HgA2ok+rxXe1RL96VWQMkF3UHdKg2U+fYmx7+YJJ3n4mI3rNZ+KneItp5hkF/BARZ
        /A79Lym68YyX2t0Fuu/1PF9BNgP6bQmLAb2E5n+EgJnOwPHsCIRYN/ZZ464Zvj+sPhJ9q4
        ouR9AsIfN4UrB9YiQFhdUezp144w03A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660763348;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMXGxDZM1X0roInqXSmFgyBNJ8wdOge6KCuTyZJ4Flk=;
        b=jM/m+IdBDeZpxCFr1AezGXoqGinm9MJB1mCGBkz2jIYWPSrNwwmkrVpTg53A3m2hX3+ExA
        6X9vwXyaBmX3qoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5E1913428;
        Wed, 17 Aug 2022 19:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CD7TJdM8/WJxYQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 17 Aug 2022 19:09:07 +0000
Message-ID: <98592410-dd31-9081-86be-fda67d3b06d2@suse.cz>
Date:   Wed, 17 Aug 2022 21:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        regressions@lists.linux.dev
References: <20220630195703.10155-1-bvanassche@acm.org>
 <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
 <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
 <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
 <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org>
 <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
 <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org>
 <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
 <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org>
 <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
 <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a T460 hanging on resume from suspend to ram in 6.0-rc1 that
I bisected to this commit.

> Unfortunately the above does not learn us anything new. The code 
> modified by commit 88f1669019bd ("scsi: sd: Rework asynchronous resume 
> support") is only called if sdev->manage_start_stop != 1. Only the SATA 
> code, the Firewire code and the manage_start_stop sysfs attribute store 
> method set that member variable:
> 
> $ git grep -nH 'manage_start_stop = '
> drivers/ata/libata-scsi.c:1083:		sdev->manage_start_stop = 1;
> drivers/firewire/sbp2.c:1521:		sdev->manage_start_stop = 1;
> drivers/scsi/sd.c:240:	sdp->manage_start_stop = v;
> 
> Would it be possible to share the output of the command below? That 
> should reveal which ATA driver is active on the test setup.
> 
> find /sys -name proc_name | xargs grep -aH .

In my case it's
/sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/proc_name:ahci
/sys/devices/pci0000:00/0000:00:17.0/ata2/host1/scsi_host/host1/proc_name:ahci

Some more details from dmesg

[    0.849373] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.852849] ata2.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
[    0.854671] ata2.00: supports DRM functions and may not be fully accessible
[    0.856181] ata2.00: ATA-9: SAMSUNG MZ7LN512HMJP-000L7, MAV01L6Q, max UDMA/133
[    0.858115] ata2.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.861584] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    0.863749] ata2.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
[    0.865481] ata2.00: supports DRM functions and may not be fully accessible
[    0.870043] ata2.00: configured for UDMA/133
[    0.871871] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG MZ7LN512 1L6Q PQ: 0 ANSI: 5

Please Cc me on further questions/steps to try/patches to test.

#regzbot introduced: 88f1669019bd62b3
#regzbot monitor: https://lore.kernel.org/all/20220816172638.538734-1-bvanassche@acm.org/

> Thanks,
> 
> Bart.

