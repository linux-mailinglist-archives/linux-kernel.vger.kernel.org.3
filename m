Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752894D78B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 00:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiCMXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCMXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 19:20:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F2A59A5D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:19:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q29so11292135pgn.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O+R/kHfFmKvufqO2riNM3OWBvfh7c4oC4bBgk3OU4rs=;
        b=k3b9zmByTfeqCsDmj2OjLn7GtvpJQ4h7Qdl6jkXZMEccR9nZgcHG8sJDsQDN8z1IVi
         ROHqfRcFP9KwmTICy7QqoS2veuIAoNtR7q5pLgURwzE3L94HehTh4ezkD3nz/NmCptbt
         hIXZdwtmlB/KwhUVUArqvsGFDTVSS55RSDzPC5Nur5ejlMgsq1BR305zCkExbqcwOtQW
         SMN+L5sJmCJUA6wHWg+i305S0OQAvSceAfHUd13zZQGkzPL6pc6guvhRu8DhRDZvPgrM
         6961UYpKQlA5GHHkQN1zUJHNyOnbzmN4I6j3F6q01O5gBD0VXv0WW1QpHldtWDzLXXWK
         AmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O+R/kHfFmKvufqO2riNM3OWBvfh7c4oC4bBgk3OU4rs=;
        b=B0lba13UM3F5Mga2roNt+1g5ueWrD3+aPMxZu69Gwq7i+Tj4fLgGhflhRGK1qT0h7B
         6H6/KkHF/028LPuUEXlPvqEoOE5c/kTOO+abWFPODUJ6j8VmN8Dlg6mUnHpDrEszN7+e
         IZOV+PEuWBsbLaEpZ5iXfMd0JiQ886UwmlX51IBIaQUtOzJ1yL4X7QzuE7ofLkoAV4u4
         MTiWnSf4c0rRbnn1s+0YdoJeq66h56gEDubo+bxHIBfL7Q7Xjlbq4wRxT2+3DQiDph6S
         dmvzxl8MRrGsGOYJva7rX0QjWdVWKunMZJG22k2Ar+GDTZ4R85vdQnfTmzDj+HIKpydK
         USXw==
X-Gm-Message-State: AOAM5305caMli/04tXz4aq/z3rAnSkAlnyLzcQ9Mf0dcVPxfhnDvX3A7
        iJYhWlojzA2qvSzIMbGjImAk3w==
X-Google-Smtp-Source: ABdhPJxFFfe7G0EiRmfWJPZDD5DaUMiZ6TuJl+HtQHVUuPDU05p4QrVBskLCBxlXAnKDFQVqZM8/uQ==
X-Received: by 2002:aa7:859a:0:b0:4f6:aaa1:832f with SMTP id w26-20020aa7859a000000b004f6aaa1832fmr21060567pfn.9.1647213572064;
        Sun, 13 Mar 2022 16:19:32 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p15-20020a056a000b4f00b004f7b71f8bd6sm4199082pfo.47.2022.03.13.16.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 16:19:31 -0700 (PDT)
Message-ID: <5161ed17-5f55-e851-c2e2-5340cc62fa3b@kernel.dk>
Date:   Sun, 13 Mar 2022 17:19:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202203132015.18183.linux@zary.sk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202203132015.18183.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/22 1:15 PM, Ondrej Zary wrote:
> On Saturday 12 March 2022 15:44:15 Ondrej Zary wrote:
>> The pata_parport is a libata-based replacement of the old PARIDE
>> subsystem - driver for parallel port IDE devices.
>> It uses the original paride low-level protocol drivers but does not
>> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
>> behind parallel port adapters are handled by the ATA layer.
>>
>> This will allow paride and its high-level drivers to be removed.
>>
>> paride and pata_parport are mutually exclusive because the compiled
>> protocol drivers are incompatible.
>>
>> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
>> chip).
>>
>> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
>> drivers - they don't handle non-multiple-of-4 block transfers
>> correctly. This causes problems with LS-120 drive.
>> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
>> or 8-bit mode is used first (probably some initialization missing?).
>> Once the device is initialized, EPP works until power cycle.
>>
>> So after device power on, you have to:
>> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
>> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
>> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
>> (autoprobe will initialize correctly as it tries the slowest modes
>> first but you'll get the broken EPP-32 mode)
> 
> Found a bug - the same device can be registered multiple times. Fix
> will be in v2. But this revealed a bigger problem: pi_connect can
> sleep (uses parport_claim_or_block) and libata does not like that. Any
> ideas how to fix this?

I think you'd need two things here:

- The blk-mq queue should be registered with BLK_MQ_F_BLOCKING, which
  will allow blocking off the queue_rq path.

- You need to look at making libata safe wrt calling ata_qc_issue()
  outside the lock. Should probably be fine if you just gate that on
  whether or not the queue was setup in blocking mode, as that doesn't
  currently exist in libata.

-- 
Jens Axboe

