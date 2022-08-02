Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C671587BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiHBLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiHBLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:42:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1565B2C11C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:42:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kb8so10868834ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xf4P1T8AnkIqXYwvL450HeEFIE7Eqes26pNoIb9Mcxs=;
        b=p3kum8xc+iRcbA90Tzi41xwEVeNCXy+DtFajdGXmAnrfKAmMPXM6/2upvECeVUZlcj
         5GNpOhofdo90I2VOuktoQ7+YqDt3J6bJrZqPzc9d+XYLrrUTU/9hKaxMCit9AI0c2gou
         QaUU/nVyQZnNFr1xficiwiIlF9AUtysMJOGLCjA3uQNMcqVTksj3hABeCEG+DJnvNAi6
         iliNIQRh28fRHqkHVx7muequICN8lnZBdE51UHbnDPFMs46qANRlm1DaoH5bHGnY3BIT
         xMsfO0zT5kIGHFYKKxpx9FGw5b199rgoKbdZxlPbQ9qUI4Qp/HGYES0w+AEpbVcPVunR
         DvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xf4P1T8AnkIqXYwvL450HeEFIE7Eqes26pNoIb9Mcxs=;
        b=Tv8osN3YBOMc/vGY1hNBAEpjtcrnVEuwVtH/Vw5UHWau9USlXzXV/oca9a4CSFRN7w
         VgdnxFDnnmC0uhIvN3rtMDi/R5xy1xNYXg5wpzoRIhSi4tJAW73SrZ+bIDQSpPZWnvXO
         47LEE49bPlM6Q2G71RiIDm3kkGsDdfsg+HfusoFBEugYwVkvQoNLFFSa2x3L56cwUNgZ
         AeM3HAEBgIS/2tRlw7ux0Gx5DJ4PTJgdPkXS6hjLfL5FTf1qIx/p0+70gNsu3c7ip8BN
         llrX3uCB/ZSnLJnd4cLl80B1Z06XYIkuOjDGQgiILmn79ogYjUCZ8E8VEgep0ILKYUZB
         O43w==
X-Gm-Message-State: AJIora+tvx4qk4ANZvDa7UOQpf8kghx2r+Rn52Mfd1imSpM7x5bKPB4b
        T4/Si5MyNSkoQQK3rWek3auug4vyZXk=
X-Google-Smtp-Source: AGRyM1sExTKkqOhbTJvaUmP8MqzPQi9Ytf894HZYJIm3RYVpY2hlo4/bJT2txtQFy72VPNcqsnh+1w==
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id g4-20020a1709065d0400b00722f46cb891mr15778142ejt.4.1659440568594;
        Tue, 02 Aug 2022 04:42:48 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b0072f5fa11d19sm6174840eje.202.2022.08.02.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:42:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 13:42:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RESEND] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Message-ID: <YukNtYnGg4FgAsOi@gmail.com>
References: <20220802033206.21333-1-chenyi.qiang@intel.com>
 <YukBz6t1n3aMbznT@gmail.com>
 <897aa91c-9d45-e16a-9b09-849fab588cd7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897aa91c-9d45-e16a-9b09-849fab588cd7@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chenyi Qiang <chenyi.qiang@intel.com> wrote:

> 
> 
> On 8/2/2022 6:51 PM, Ingo Molnar wrote:
> > 
> > * Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> > 
> > > It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
> > > this kernel has been kexec'd from a kernel that enabled bus lock
> > > detection.
> > > 
> > > Disable bus lock detection explicitly if not wanted.
> > 
> > Makes sense.
> > 
> > Just curious: in what circumstances does the BIOS/firmware set
> > DEBUGCTLMSR_BUS_LOCK_DETECT? Does it use it, or does it enable it for some
> > spurious reason, without really using the feature? (Assuming you are aware
> > of instances where this happened - or was this simply a hypothetical?)
> 
> Yes, It's just a hypothetical for BIOS/firmware. Kexec is the real case I
> met with this problem.

Fair enough, I've tweaked the changelog a bit to de-emphasize the firmware 
angle, and applied your fix to tip:x86/urgent.

Thanks,

	Ingo
