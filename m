Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B362A4D07F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiCGTvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiCGTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:50:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D94FC7D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:50:03 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id w7so18431840ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=;
        b=D9EOkrsYV7Xsyxf/6CdXzNXALautOeZBiGjeX/I4hjBM8EynsqoHdUlfNoDp+n97Cx
         ak3LSSmjyVYTrUo3k8wUJ/vzRpIHWWk2A1GZUSlCpFOfDx8AVtsHh7/RvdGmbKIXfOBC
         YVz8ptxroGcIhO1e7z2glBGmsSfeQ1TB8MJIyJfzlEnsrLK68ilH9PTwj96YEXzZAGUU
         tXTF1Wvp5ogod/B+rQzAQLizXotw0U4w14DYF56LdpsZt8PsTNM1yIYfEEx+43rDvjJU
         HF9j6lUn/42Oauqt03YtKhF3B1Gfi30Qoe60vsMifkKbkyB5LAaFvaavy4m5SElM4DZf
         RjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=;
        b=3BAmUHgpzJKQEfug3/xM0NoggVcCONje0UTrh4/LtQqfCnuT++gIxhJJXMojXibar0
         +4r0AL1PpGTMpZRKmxWlDI62thaInTxfIP1vwSTu8C6/JkWi7Re3NDzh9dOAqFlqkdsm
         qlhQecgVsbTMzDWcZDgxhLs/9egR1rYZco6ZdkWxdM5gu1T5kvVAtNHXGFM6Nvy6Ftwu
         zOPZG3se+OQIE2qCBMVS1ucSOZnUEsQqxnYSwr6aRUJ/2WAA4Ei7ZEulWr9BbzGnd1Ea
         16a8BuJyMx5fKQjA0vcuQq3NamwQoFoqE8iemzTLTEhfCRtZHF0NOwSFgScvE87MEjfZ
         DD5A==
X-Gm-Message-State: AOAM531uO4ZM2dtUMjhBuHF0WoZBJH1EXmkJfZbv9OHtiOQgb/b+yQhd
        rndLvSAneBRFeBz2HOE7QxBseA==
X-Google-Smtp-Source: ABdhPJybq+mzRA9wXefyDpbSCzRp9JiXKbIPz1Fc1EWfxA+XSQ7k68avZwGrMkTiAo8s8+pRBO+9cg==
X-Received: by 2002:a02:5bc2:0:b0:317:b050:cba with SMTP id g185-20020a025bc2000000b00317b0500cbamr8910432jab.301.1646682602578;
        Mon, 07 Mar 2022 11:50:02 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s13-20020a056e0218cd00b002c5f74a97d6sm11807418ilu.39.2022.03.07.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:50:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, hch@lst.de
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
Subject: Re: [PATCHv4 0/8] 64-bit data integrity field support
Message-Id: <164668260179.56567.6298714072189307417.b4-ty@kernel.dk>
Date:   Mon, 07 Mar 2022 12:50:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 12:13:04 -0800, Keith Busch wrote:
> The NVM Express protocol added enhancements to the data integrity field
> formats beyond the T10 defined protection information. A detailed
> description of the new formats can be found in the NVMe's NVM Command
> Set Specification, section 5.2, available at:
> 
>   https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf
> 
> [...]

Applied, thanks!

[1/8] block: support pi with extended metadata
      commit: c340b990d58c856c1636e0c10abb9e4351ad852a
[2/8] nvme: allow integrity on extended metadata formats
      commit: 84b735429f5fe6f57fc0b3fff3932dce1471e668
[3/8] asm-generic: introduce be48 unaligned accessors
      commit: c2ea5fcf53d5f21e6aff0de11d55bc202822df6a
[4/8] linux/kernel: introduce lower_48_bits function
      commit: 7ee8809df990d1de379002973baee1681e8d7dd3
[5/8] lib: add rocksoft model crc64
      commit: cbc0a40e17da361a2ada8d669413ccfbd2028f2d
[6/8] crypto: add rocksoft 64b crc guard tag framework
      commit: f3813f4b287e480b1fcd62ca798d8556644b8278
[7/8] block: add pi for extended integrity
      commit: a7d4383f17e10f338ea757a849f02298790d24fb
[8/8] nvme: add support for enhanced metadata
      commit: 4020aad85c6785ddac8d51f345ff9e3328ce773a

Best regards,
-- 
Jens Axboe


