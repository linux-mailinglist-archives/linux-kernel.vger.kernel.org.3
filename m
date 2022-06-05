Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D3F53DB2F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350998AbiFEKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348259AbiFEKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:00:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ECD35853;
        Sun,  5 Jun 2022 03:00:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so23781060eja.8;
        Sun, 05 Jun 2022 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uaKvjKGbSmoQ07fEbmYnQns3tYMzfecUZ60MURH83M=;
        b=T4n/1EMFUZrSx7UxlniheEPsyK0J/HcMJjg13Hltuxx4q7BvxDJFYs7PqoK540wgYz
         CwTCD/BT9RZRUkDZMUMDSLLKLnLG7lyP8mqi/NwQHg3VY35R+tUskyAkinKmnXQn0faw
         FutBJ3V2YYnl8yZjCOzcKgG1OmW1KIILuAWijJO3Sg6iirKKDO2183orcKiVdEBvTnYB
         5+KyWCT0uVJXW9h77qnAST5l97vbG6UoZ2iX/7g2snKRokoTTn+kqT6ofN+rYlmU2JXh
         z+pqpnGZR7UDSHqDeyrIX6cKPaAPMIsADLUwDh6sWtj9Yita5EfIO2AQc57dKmVdaXl9
         kzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0uaKvjKGbSmoQ07fEbmYnQns3tYMzfecUZ60MURH83M=;
        b=bmwlRu0Ns4na+d1kozahmwCFal1J4077jCXbfcHgPxxKFsE8z6S1ZaAJWhTakEmFK0
         /pE3M04mzJaEz4R5Cnte9iITRVhgzRY/rA9HBwFuJ1wJTGOG5qEj0/NIRM6hqwdQsuu5
         09uDBmes0jKa+HakPZHo4cua7H4rMnfBLim7mCtfyQHiLnv4YrJHb5LpeqC5vpIJZgD2
         ZrEs2m1WM9C1efJs2OcCU9Pm0isziRHRB0OCOsT17qIAFGrFL1PavF9MqxMzPRV4K7FD
         PFUfOW9du4Jig9S+7EnlN4ELrHLC99DT9fPFelL+3cI+B/sfjLZFj3z6OGulJB1DVoxM
         2VaA==
X-Gm-Message-State: AOAM530F7ssqp71+CowEPmZ70BXUKqNiGs/iYzbmF3IVC13RbHQj4K/O
        Ut2eQdQRp4TSesMeoR3p1E8FCAO1NSI0pA==
X-Google-Smtp-Source: ABdhPJxPBfpf52tfa2nmI8jF5dDin8Ok7G/xwoQpEd6mGK/fqo93X5hcpnNcPpVc93WogzRON1kApw==
X-Received: by 2002:a17:907:3f04:b0:6e8:4b0e:438d with SMTP id hq4-20020a1709073f0400b006e84b0e438dmr16534088ejc.391.1654423212035;
        Sun, 05 Jun 2022 03:00:12 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id me3-20020a170906aec300b006ff01fbb7ccsm4989986ejb.40.2022.06.05.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 03:00:11 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 5 Jun 2022 12:00:10 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michael Schaller <misch@google.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
Message-ID: <Ypx+qusVyLJEEb/r@eldamar.lan>
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de>
 <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
 <20220603132313.GA20886@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603132313.GA20886@lst.de>
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

Hi,

On Fri, Jun 03, 2022 at 03:23:13PM +0200, Christoph Hellwig wrote:
> On Fri, Jun 03, 2022 at 03:21:28PM +0200, Michael Schaller wrote:
> > Thank you, Christoph! <3
> > 
> > Patch https://lore.kernel.org/all/20220527055806.1972352-1-hch@lst.de/
> > does indeed fix the issue.
> > 
> > Could this patch also be backported to 5.17 and 5.18?
> 
> It should get picked up automatically based on the fixes tag as soon
> as it hits mainline.

As it does not apply cleanly to older versions, this probably will
need a sperate turnaround, but AFAICS it's just because of
a0e286b6a5b6 ("loop: remove lo_refcount and avoid lo_mutex in ->open /
->release") changing context of the fourth hunk in
drivers/block/loop.c .

Regards,
Salvatore
