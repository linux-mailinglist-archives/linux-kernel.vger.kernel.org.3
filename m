Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE759767B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiHQT2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiHQT2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:28:52 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED12873F;
        Wed, 17 Aug 2022 12:28:51 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id q16so12788801pgq.6;
        Wed, 17 Aug 2022 12:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eIIJ90bC7P6FQljG0Svb0/jyjx1J3a6+sZdp1aw3LWc=;
        b=xJ5nXoWOUm3MYviUc2Gs4cJVbrVxpcpOWAC6qVbR/Ejl92Esqeus9dZtnZy47syROu
         zx7iH/x/CIoH2UaeUeLVX+dfVu9m6kX+7sW18ajZ1OnQRRDPGiWKPmayI1LAVqISeSoQ
         U8W3aLREUrGZ3wstM5wwE1klMBLAoJO/C4ztXByvh+T+Jepm9CLlq54rvusNw76qgt4v
         uVMR8lFJLyRM0xpXvfepDXQwQcGtP/Bp3LA2W6Sz3tOP2wcGG9KCUUEIQCKf1zdA2LIH
         vth+kBpPiV7Nlud9IoELI9tGR2cZF+O6Uthij+B8e2AuYSDbNBD0ViM4ckpyR59x0Fcv
         /L+w==
X-Gm-Message-State: ACgBeo0NGMBrqdWjJm3oYSx+5IUssZq3zcJ/uAWs9PwiicTEw/Ujtkfj
        GEMH7x/OYFP83CXj5fNOtgSnw0dTGxM=
X-Google-Smtp-Source: AA6agR5N1VLxg1D0o/efqSo+AfelEHXkXuS7UXlv7yTPvJeIol1q15tQVj7kMfdJLeiP19U+aJHknA==
X-Received: by 2002:aa7:88d3:0:b0:52e:ade6:6192 with SMTP id k19-20020aa788d3000000b0052eade66192mr26944323pff.41.1660764530467;
        Wed, 17 Aug 2022 12:28:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:55b:6314:9f8d:7bcd? ([2620:15c:211:201:55b:6314:9f8d:7bcd])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b0016ed8af2ec0sm312931plf.29.2022.08.17.12.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:28:49 -0700 (PDT)
Message-ID: <41b3cf11-6129-60d8-436a-b957b442a4bc@acm.org>
Date:   Wed, 17 Aug 2022 12:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
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
 <98592410-dd31-9081-86be-fda67d3b06d2@suse.cz>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <98592410-dd31-9081-86be-fda67d3b06d2@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 12:07, Vlastimil Babka wrote:
> In my case it's
> /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/proc_name:ahci
> /sys/devices/pci0000:00/0000:00:17.0/ata2/host1/scsi_host/host1/proc_name:ahci
> 
> Some more details from dmesg
> 
> [    0.849373] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    0.852849] ata2.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [    0.854671] ata2.00: supports DRM functions and may not be fully accessible
> [    0.856181] ata2.00: ATA-9: SAMSUNG MZ7LN512HMJP-000L7, MAV01L6Q, max UDMA/133
> [    0.858115] ata2.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    0.861584] ata2.00: Features: Trust Dev-Sleep NCQ-sndrcv
> [    0.863749] ata2.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
> [    0.865481] ata2.00: supports DRM functions and may not be fully accessible
> [    0.870043] ata2.00: configured for UDMA/133
> [    0.871871] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG MZ7LN512 1L6Q PQ: 0 ANSI: 5
> 
> Please Cc me on further questions/steps to try/patches to test.

Hi Vlastimil,

Thank you for having provided the above information. The root cause of 
the hang is not yet clear to me. I was wondering whether the hang 
perhaps would be triggered by controllers that only support queue depth 
1. However, in the above output I see "depth 32".

As already reported in this email thread a revert for commit 
88f1669019bd62b3 has been posted on the linux-scsi mailing list. 
Additionally, Greg KH has been asked to drop that patch from the stable 
trees.

Thanks,

Bart.
