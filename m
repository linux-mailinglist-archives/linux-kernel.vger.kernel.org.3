Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90E52EFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbiETQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiETQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:00:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3D8179979
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:00:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a38so5218378pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=okCt9co+SF5ECluxT3Dng4QP4iBob3A/TVpznYKwSg8=;
        b=zqLiNginaQn85znSiRH/fAXHu8QeMoQLwXyIEAytzgOoAdvrHgDcZxbfKf1jqPLz/c
         tKnLaT48lgX/ayU/VjWzEiSc2jMy8srl/ibakog6RRbXre8XE+ocQA0KmrzjxFe1jSg2
         aL2+Sy8TWqWBkXkEbb0Mbx6kJA5i7/kOpKjEejm2g8isg66JEIK9ikfDEJhFe7ZJE6S8
         bb9aoEwFhibjl2JlBcbb+7pu2M29yVPAxr/Fvv4187/fCkrkxCTY2unTrL/GpeQnXAbI
         6eBf/Rvr8GF3SBwT328vUPF08si8N6f22UCnNftX7R2GO0udfWMHA7slAc15jDRi6mIk
         R1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=okCt9co+SF5ECluxT3Dng4QP4iBob3A/TVpznYKwSg8=;
        b=tA0CccUQo8H3Tcc+Vwj55RN5k9J55qJ/RCMfBGUndEl0QAsuVbVl99dAp1P6rTVyHn
         uu66I15kSde0oPESOe9XY1bLkwxG/pNtkdVkQ87Li6PEs/vz+7El6KgqPJALutBmx3Gh
         er4FB8wRRGMPMynfVZsafH7VQV2BH2DssLxoaq0oR0aaxdyIOxlOlN0or5aM4Fl9H/ck
         bxl0C21KEqDFD6IZp0zEH73SNvSwM6/KnGgnptOH2lvO/K+HhHgx9sukyvfPLhCYzbVV
         XJd6LiNXvDLROX5+i1Tn9Tbi4ME2VIjcWG2DcJ7lz4q9Sd7+IJf/e4z+t/IBH+jLLEHK
         K71w==
X-Gm-Message-State: AOAM532AxqBQMHFnxWMz8rvL8k7/ZBlgiOwPwUf/YOAnTjd1yvhZqW3q
        6UP2A7V0KFHezf7vNtn7VN7I8YO5jH73yw==
X-Google-Smtp-Source: ABdhPJxrt72KlCaLrKYHZH4Wstko6KdGJOf9HseUzBWm7phKH3GtRG+d3WkuWZMYjoOUPZaZmaqKjQ==
X-Received: by 2002:a63:7247:0:b0:3c1:a8ab:fc6 with SMTP id c7-20020a637247000000b003c1a8ab0fc6mr9217578pgn.602.1653062441719;
        Fri, 20 May 2022 09:00:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q14-20020a056a0002ae00b0050dc7628186sm2018271pfs.96.2022.05.20.09.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:00:41 -0700 (PDT)
Message-ID: <76a601c2-a32d-1c28-3a9c-f645e57e3af1@kernel.dk>
Date:   Fri, 20 May 2022 10:00:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe3vFmqx4Yua0a1@zx2c4.com> <72344aad-b5ad-b317-d36d-385cb16d5204@kernel.dk>
 <Yoe6iltcPVcTL6dD@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe6iltcPVcTL6dD@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 9:58 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 09:51:06AM -0600, Jens Axboe wrote:
>> ABI. Obviously that can happen sometimes, but I think this one is
>> exactly the poster child of breakage that should NOT happen. We took
>> away a feature that someone depended on.
> 
> I suppose somebody (Meta, I presume) *did* notice the breakage, which is
> sign enough.

Indeed, this is how I found out. And then you have to wonder how often
this has happened elsewhere where nobody bothered to report it, or how
many are still waiting to happen because they are still on an older
kernel and just haven't upgraded yet. Or upgraded and rolled back
perhaps.

None of the latter really matters, it's eventual breakage there, and
very real breakage right now for the first case.

-- 
Jens Axboe

