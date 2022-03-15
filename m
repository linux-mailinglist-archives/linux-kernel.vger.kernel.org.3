Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2424DA381
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351483AbiCOTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiCOTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:54:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF0286C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:52:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so414537pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0Z/mKLEzNMGFhUbWMgWDYenOVpB+Pa0RFNSj7m6Lq0=;
        b=DdjagM6iLgCzTKKLhzNMMpzAvoMKa5fc95CsnEsQKICrPW80MBMPSL8FQwe5uHgRne
         RXt4V1BllKjKmpk354xuyBEOLu/sckjJQ1RvERNexLsSTJjBPfadOsH2xg5KFK6Aj5vN
         mZQUoj8QOCqRNk5BhjoQvb21U3wZRO5bpYjQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0Z/mKLEzNMGFhUbWMgWDYenOVpB+Pa0RFNSj7m6Lq0=;
        b=u9lXRhiNnvAcUSoSRfKCYMhcnAXJ8h7leDa/wu1B2V4/hrnnFCKaVtRFnCYafrsCNb
         KVZoR0bBWRH/18+wQmie0NfZxaAmu+n9QyAS4/QluL9SeH3x5j+o/jjf0s4S6EdfK5S3
         jVz8NCfJ10tQ/GeSDxLvFQC2/ThOs0PrAC3hdM/gk8XbHpLEo34tZuDU0LqBLHUEtKm7
         y0AbTmCMUIBuTsXBNa+SweFz0N/XoC+VOugbKi9xYI8PyP2ydViGZkI0fDjDeYeY/MAT
         PafvVeVa0AQKrl1QkSnqgv3WNAb6MFy9u/xvgg5kAyRM7qYqKxOq2VBctO7TXEb0NQMc
         kh1g==
X-Gm-Message-State: AOAM531miotbyYWs4edVU8R3+x1QPhOeyT/OrsjAMnACeW/f5ViWexFe
        5xekBdjPeozG2TG5xnGlxZkaNhYYje8jtg==
X-Google-Smtp-Source: ABdhPJxVH1RzoNFr9lnuMz/Kq4V/O4Hk1z36zluI47SVOlMM23quvMSJX6PsAza8rFFcRnmxr300xw==
X-Received: by 2002:a17:902:da89:b0:153:349c:d240 with SMTP id j9-20020a170902da8900b00153349cd240mr23369729plx.73.1647373978733;
        Tue, 15 Mar 2022 12:52:58 -0700 (PDT)
Received: from ebps (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7888c000000b004f3fc6d95casm25503039pfe.20.2022.03.15.12.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:52:58 -0700 (PDT)
Date:   Tue, 15 Mar 2022 12:52:55 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ebadger@purestorage.com
Subject: Re: [PATCH v2] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220315195255.GA1523195@ebps>
References: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220315171425.GA1521135@ebps>
 <2d4e8811-dce6-c891-e92d-e3746434685e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4e8811-dce6-c891-e92d-e3746434685e@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:26:46AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/15/22 10:14 AM, Eric Badger wrote:
> > >   # Prep injection data for a correctable error.
> > >   $ cd /sys/kernel/debug/apei/einj
> > >   $ echo 0x00000040 > error_type
> > >   $ echo 0x4 > flags
> > >   $ echo 0x891000 > param4
> > > 
> > >   # Root Error Status is initially clear
> > >   $ setpci -s <Dev ID> ECAP0001+0x30.w
> > >   0000
> > > 
> > >   # Inject one error
> > >   $ echo 1 > error_inject
> > > 
> > >   # Interrupt received
> > >   pcieport <Dev ID>: AER: Root Error Status 0001
> > > 
> > >   # Inject another error (within 5 seconds)
> > >   $ echo 1 > error_inject
> > > 
> > >   # No interrupt received, but "multiple ERR_COR" is now set
> > >   $ setpci -s <Dev ID> ECAP0001+0x30.w
> > >   0003
> > > 
> > >   # Wait for a while, then clear ERR_COR. A new interrupt immediately
> > >     fires.
> > >   $ setpci -s <Dev ID> ECAP0001+0x30.w=0x1
> > >   pcieport <Dev ID>: AER: Root Error Status 0002
> > > 
> > > Currently, the above issue has been only reproduced in the ICL server
> > > platform.
> > > 
> > > [Eric: proposed reproducing steps]
> > Hmm, this differs from the procedure I described on v1, and I don't
> > think will work as described here.
> 
> I have attempted to modify the steps to reproduce it without returning
> IRQ_NONE for all cases (which will break the functionality). But I
> think I did not correct the last few steps.

Well, the thinking in always returning IRQ_NONE was so that only setpci
modified the register and we could clearly see how writes to the
register affect interrupt generation.

> How about replacing the last 3 steps with following?
> 
>  # Inject another error (within 5 seconds)
>  $ echo 1 > error_inject
> 
>  # You will get a new IRQ with only multiple ERR_COR bit set
>  pcieport <Dev ID>: AER: Root Error Status 0002

This seems accurate. Though it does muddy a detail that I think was
clearer in the original procedure: was the second interrupt triggered by
the second error, or by the write of 0x1 to Root Error Status?

Also, in terms of practically running the test, I find the mdelay() can
block other interrupts and can make running the test sort of confusing
("is it not printing because the interrupt didn't fire, or because it's
spinning and blocking my NIC driver?" :).

Cheers,
Eric
