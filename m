Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB74E466D69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349262AbhLBXFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhLBXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:05:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2215BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 15:02:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id u80so1013303pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eOjlFoU5VQjL4pImZvQTpQdfwgTEDWhWTxRlxxmPIzc=;
        b=S4hu07MGAbbwjXLuQQVsoaFOznFygKx8xBda9aSDxlAa5j6c6EaVNk9aGhTL/vFEzu
         dB+diKUZI4jPjEfyux1UqKUA/nF5n/FxGxkkJ4t9yqFaGXQ/znUuVzbMZLq22c5/wfsw
         dRuyWPO9covcyBdbDyZVEiQquseL6iSkHz2kmQZ2BEzhKW3byySzUzkWrGBJfiyxXmo1
         iHL9PxO0T3cVEoaEB3KGJi2X+0X4wH08mnvnIgNEbPaP9Oaex00hTMj9ol/6fUeu4MNW
         M23CFTbE7d9E3qKF336tR6yMaBo/JkPdhKc1hjansH7ASVwS7WpWXKgrfWl5ZPBAhjVU
         8gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eOjlFoU5VQjL4pImZvQTpQdfwgTEDWhWTxRlxxmPIzc=;
        b=EC2JtNaz7pwUqYjSsPqr0aE5uoucPUJuCW3kWuCufc9dKLX/WkCNiDlWdeEkUsXJtk
         85aUvsOdLi69QgAkQ3KMu+nczjNM63DVqFcpy2xwEnd1VEc+L6AmPrW2GqR77HR90rHw
         aQRDq2tNsvalj09DcCqUsjEyoa/vtl7WIfG6tu1IGfue7AmFescZYdDv1eSZNyq6IzZM
         moKwAttV8P9wQSSj4BZ+aQzidMvoBKOnC7yKgSzHR3hNebi1UkIbg58SJ6fwJRi9K0bp
         cNb/JBFybN8oMd8Ju8w8bHIc8MRrF0XpcPUGM1MeGuAJImXiV6iOcxN8oJX93dR2EbDp
         dXsw==
X-Gm-Message-State: AOAM530JhnOT7qhjvenDjRnKg3OcMreGsooGACljDyL8IXvkryTkv5s9
        d0cRPLyGlTuGxoprWNNGYMVD112YpZ0=
X-Google-Smtp-Source: ABdhPJyHjGYJ3CPwnPKqCPJePlpXY7MDr4T2xsnJk2tl7F/XwoQVRgrWW1vmJ+ubHb0L2cWrYyamsA==
X-Received: by 2002:a63:d257:: with SMTP id t23mr1623182pgi.533.1638486120477;
        Thu, 02 Dec 2021 15:02:00 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id gv23sm3396448pjb.17.2021.12.02.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:01:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Dec 2021 13:01:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/2] workqueue: Fix hotplug/scheduler races
Message-ID: <YalQZhFcLhtHnEby@slm.duckdns.org>
References: <20211201151945.632214-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201151945.632214-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:19:43PM +0100, Frederic Weisbecker wrote:
> It's a resend of "[RFC PATCH 0/2] workqueue: Fix hotplug races", with
> appropriate tags added and scheduler people Cc'ed.
> 
> Thanks.
> 
> 
> Frederic Weisbecker (2):
>   workqueue: Fix unbind_workers() VS wq_worker_running() race
>   workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

Applied to wq/for-5.16-fixes.

Thanks.

-- 
tejun
