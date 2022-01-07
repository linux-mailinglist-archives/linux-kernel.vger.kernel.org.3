Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670DC487E46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiAGVa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiAGVa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:30:28 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362EC061574;
        Fri,  7 Jan 2022 13:30:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v25so6505016pge.2;
        Fri, 07 Jan 2022 13:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kz8qm+v1ne3z5CUVGP2ykHvg0hzupUzPna1i+Alij6k=;
        b=TPPfku90RRWCK2zWAZzLBc2/HybyKErF5kbLSLV6aLNHiteEm5Kgbb5zUwc4kf9nV4
         4gfKH0O6sr9FvwjylhrQ8vhtBbrzMzy1vHvDLQfcipg+wHPl+E79n5KIjOoty8QKjd5f
         CqeGK6A/lV4w6pcrPrWvJrMLLvVte+1QnbBwTv/P/qmSn8pK3Z1pZ365s1PkjGV0V/6d
         DjWBAX1MZqnCM9wMbkHidvcL+Ifn2Z2oiLHugHn4rwWO5DAuWHgu8b/BTjpesPy3ssWv
         S9y1ijsQYfKh62NOUui+e7g6bVM/x8motai46gJZAtsB3hR0eOp52bVEmzFnkqM+a6W4
         E+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=kz8qm+v1ne3z5CUVGP2ykHvg0hzupUzPna1i+Alij6k=;
        b=T4flqzAChatiZQQctNCmFj9LJViYON6v6gE+To63WgzctvAhuQxSTx63PKO1CmpH5l
         Ibm0UyZF8QLcAVF877Fslc3aVSCh1YY77XlC6VH70GPpfoGqMYzy544CqJ2+Dz7ocV90
         vaxTdbIbX1hCtcgyNM6HLZUzcNWEuCRNdIQq1vSJ2jUjyVTTdkx03uayU0F8A3dgZMH3
         nrbMc8nSlumLEi/2DmRcu4X2GSk1LZi7XtRL6rD2SIMXlUnrwNiCkSiR3xOpw2588VEv
         ypzDr8zUtvOS1D99G6QtnQIXbxBuI859yeMacHKhtFypHBvF1TXTaTY0Wto5Ql5YKvBW
         1KQw==
X-Gm-Message-State: AOAM532gZzntIxWbstGbE2LZpBAp2z6iSf4EvVu9j+cKd4nR6n4Cl+YB
        sqxoXHJaVj3AIUTiiYtdb1g9g2zgj7m4Mw==
X-Google-Smtp-Source: ABdhPJwM8bcozgA9ASTaRRN3AGYhHvYodatBMxcgsCU+Ne72WymZ4/53TZ7FUf9N9lJaXow3O8SZew==
X-Received: by 2002:a63:43c5:: with SMTP id q188mr56934753pga.304.1641591027871;
        Fri, 07 Jan 2022 13:30:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id w13sm5375527pgm.5.2022.01.07.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:30:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Jan 2022 11:30:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jeff Garzik <jeff@bloq.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ata: For what PHY was debounce delay introduced? (was: [PATCH v3
 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms debounce delay in
 `sata_link_resume()`)
Message-ID: <Ydiw8hxkNWDO2nW3@slm.duckdns.org>
References: <20211229161119.1006-3-pmenzel@molgen.mpg.de>
 <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
 <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
 <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
 <fbfd865f-c88c-6ee1-6cb9-8194e170cd3a@molgen.mpg.de>
 <c6748a52-fc8f-3309-31c2-973a9e69a7e8@opensource.wdc.com>
 <33deca4a-abed-123c-9530-3f15740a3261@molgen.mpg.de>
 <27da2f5c-ca6c-1d64-3d05-5453f11e298f@opensource.wdc.com>
 <66edbfd4-063f-b995-0d15-982d365dd7d7@molgen.mpg.de>
 <CAHy7=M10exWuVJtDVo+w36YKadY533GttzwrKxPnotHf8-JQnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHy7=M10exWuVJtDVo+w36YKadY533GttzwrKxPnotHf8-JQnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 05, 2022 at 03:49:58PM -0500, Jeff Garzik wrote:
> On Tue, Jan 4, 2022 at 6:34 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
> > [cc: +jeff, +tejun]
> >
> > void sata_phy_reset(struct ata_port *ap)
> > {
> > […]
> >         /* wait for phy to become ready, if necessary */
> >         do {
> >                 msleep(200);
> >                 sstatus = scr_read(ap, SCR_STATUS);
> >                 if ((sstatus & 0xf) != 1)
> >                         break;
> >         } while (time_before(jiffies, timeout));
> > […]
> > }
> > ```
> >
> 
> The piix did not have SCRs, as I recall, so it wouldn't apply to those
> chips.   I don't recall further than that.
> 
> Presumably just give those early chips a "needs delay" quirk, and then
> start testing newer chips to make sure they survive an immediate bitbang?

I don't remember exactly but most likely the sata_sil chips, I think. But,
yeah, the way forward would be converting it to a quirk and gradually lift
them with tests.

Thanks and happy new year.

-- 
tejun
