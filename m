Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B095554CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357118AbiFVO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353545AbiFVO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:27:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB7B27FD0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:27:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c13so19701454eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=47AoC0v2wILDvcUXFYwOTE5vORkj5ZcOTwRsnbRawOo=;
        b=j8oZdB6ZZ75uWTGBqbX8WgBapmrnSRJXitIoqCp6Xoe2R+8SRod75BXuMkUeCX2pxl
         2k+8Z8vItisu7trL7y99LrLx2gBGM6gPDbpp2VAKPRWIsopgwZNmeuxVNV/CYKYm+pl7
         DXuNahLSZ9HuBu0vAHvbA/D1s12gdL6/K47tcdQHjaFJMEfWhX7Enwh7DNq5dCCWn2Ma
         0ks5Nn9/apA5X2pqU+25XggaL2dbK6Gks0TEU2XXMyb9FNth5gL2H9Pf99ZvpjUvTBJ/
         uB8eeeP6YAWc83DOhyy/hpYA2mL7ozcureerq3kP6tsuH6Rm4YCJxer750F2dyr79Y+b
         aB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=47AoC0v2wILDvcUXFYwOTE5vORkj5ZcOTwRsnbRawOo=;
        b=7N9TzZWlbXX8whYbv4IlvrGdyDvDE0xA8gyv6En5H3BMv4ARKLAaloqGny9VSD93Bv
         5IdhfMEXddyHOzJ071M8NEmKTjPKSh9Sk/MAADoRqK3Qe/1lwre8DT9fiGfWb+NuKXSG
         OkXstk1sfG9YnZsPcaHvaQC1iYOWKjYCYi/DW2CYghJAvjl5rZopt55545/81RhQq9zy
         qTWIODPoec/u9ZavXEEWW3j9MkgwSBsHcMkqjr808uu069XFcVMUjlyXIQ6UAwTmKloF
         keq1+aBqN1neSO8QR3T4bumwBRsOEHmYczwocr48XxXHDqQpkYdZgED1VEZWPp3vh8Su
         8Ajw==
X-Gm-Message-State: AJIora/LQjU3s0zK5WfpbOh7X4MeCyuMqyhpglEGJtlrrpcmMKsfFgIo
        T6ej7j3GkqaPo17gslnzXEU2w/Tiv1mcAQ==
X-Google-Smtp-Source: AGRyM1tfSuPe7F4pQuhHw2yfoXYHX05iuT6bACWWy7kat4VpIRwVkU5t89Rc1Bw1Fb6+DEayZgY1+w==
X-Received: by 2002:a05:6402:4301:b0:42d:e8fb:66f7 with SMTP id m1-20020a056402430100b0042de8fb66f7mr4467435edc.229.1655908029834;
        Wed, 22 Jun 2022 07:27:09 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906480100b006fe9f9d0938sm9525240ejq.175.2022.06.22.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:27:09 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 22 Jun 2022 16:27:08 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ChenBigNB <chennbnbnb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2022-1462: race condition vulnerability in
 drivers/tty/tty_buffers.c
Message-ID: <YrMmvAoCAKmr7UhZ@eldamar.lan>
References: <20220602024857.4808-1-hdanton@sina.com>
 <0dc35f2e-746c-bcec-160c-645055a6f8d2@kernel.org>
 <ca7fdc92-b94e-56e8-3d4a-739535cdf8c3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca7fdc92-b94e-56e8-3d4a-739535cdf8c3@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Wed, Jun 15, 2022 at 12:47:20PM +0200, Jiri Slaby wrote:
> On 02. 06. 22, 6:48, Jiri Slaby wrote:
> > On 02. 06. 22, 4:48, Hillf Danton wrote:
> > > On Wed, 1 Jun 2022 21:34:26 +0300 Dan Carpenter wrote:
> > > > Hi Greg, Jiri,
> > > > 
> > > > I searched lore.kernel.org and it seemed like CVE-2022-1462 might not
> > > > have ever been reported to you?  Here is the original email with the
> > > > syzkaller reproducer.
> > > > 
> > > > https://seclists.org/oss-sec/2022/q2/155
> > > > 
> > > > The reporter proposed a fix, but it won't work.  Smatch says that some
> > > > of the callers are already holding the port->lock.  For example,
> > > > sci_dma_rx_complete() will deadlock.
> > > 
> > > Hi Dan
> > > 
> > > To erase the deadlock above, we need to add another helper folding
> > > tty_insert_flip_string() and tty_flip_buffer_push() into one nutshell,
> > > with buf->tail covered by port->lock.
> > > 
> > > The diff attached in effect reverts
> > > 71a174b39f10 ("pty: do tty_flip_buffer_push without port->lock in
> > > pty_write").
> > > 
> > > Only for thoughts now.
> > 
> > I think this the likely the best approach. Except few points inlined below.
> > 
> > Another would be to split tty_flip_buffer_push() into two and call only
> > the first one (doing smp_store_release()) inside the lock. I tried that
> > already, but it looks much worse.
> > 
> > Another would be to add flags to tty_flip_buffer_push(). Like
> > ONLY_ADVANCE and ONLY_QUEUE. Call with the first under the lock, the
> > second outside.
> > 
> > Ideas, comments?
> 
> Apparently not, so Hillf, could you resend your patch after fixing the
> comments below?

Any news here? I'm not sure if I missed the followup submission but
was not able to find it.

Regards,
Salvatore
