Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3B5138B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349378AbiD1PnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349433AbiD1Pm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:42:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C8B8205
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:39:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d3so2227867ilr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=OTiwe2B8rcUTI1j/SK3IzHaXYBhsCj6uIQbvt9mJoW8=;
        b=ipfJ7mfMBx1Gh7S27tOSuhiVa4tGtVpllk6Wp5RAxvOy62JewaAVekq9L7hm3Rw4Dz
         CXzsm9JZz/m5595XdVfjTk1u/u53HX2rbqoGiwpAJ0yH3l+ppPrfg6w+07ZoOCCt8y0B
         SjumJbNHwlEv2zNZmCR2hHbghukJqeDZtbDGqclEHxfmJ8diXalU9JjDQZ3/PhWz9UIT
         SNOvc0+zcKpNV5BKUQLpjoi6wjRd5FXZIG1VGxNe+/VQTEDSv36gbBAybf5N3vAW3SN0
         7YTIjH4j7hb/++l/0QN9k6hGAGczcQguvm5tkgsUCuk12wxDejfjV/U9kMjcVMuneh6z
         gIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OTiwe2B8rcUTI1j/SK3IzHaXYBhsCj6uIQbvt9mJoW8=;
        b=kP3kT29lne5vZblt8oVgBhKF1EmU9zKnG8NMjsdYS3WSbKfoYijY9uDmp8y1pUzDPh
         efeBDjaKT8FJJJTDUN3w9Y5qFzP3pKnCdkSAY6qXIxjitkzsVNRYUaPl4doQZU2CeukC
         Rs8Y2EMvgNK5RIRIYh/+BDjHNWE+yIh9TuECtIGh41jv31dh3/BdXNoMU0+dIbmr9AcH
         FXFdKDE4HCDHmgBsiwtWslcMblVsBo3K8W276NJDNGQ2sDphIDzAuM/4CP7eYA1uoZEn
         MTN+oN71HkIj0hedEa7ePDFKxog+4eRbe2LYmH1IIj7oC2lamu4NCt3x+K56m+yzsFZZ
         5K0g==
X-Gm-Message-State: AOAM531Vp7d73OZioQONtjFGe3LQs6Fs4Aw/PVcJFAi04siREGUCz3qB
        80aM7ehAIs4wS4VxSceUlpirbA==
X-Google-Smtp-Source: ABdhPJwoRg8obuWEqLY+gYStieJPIHXgUsTUSpgt9B5G+awAdRdZhGFqY8ZPjyjvL7QqNgZHMMsaIw==
X-Received: by 2002:a92:c54b:0:b0:2cc:3de1:ae5b with SMTP id a11-20020a92c54b000000b002cc3de1ae5bmr13217754ilj.288.1651160373684;
        Thu, 28 Apr 2022 08:39:33 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u1-20020a056e02080100b002cd6b0e772dsm110390ilm.45.2022.04.28.08.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:39:33 -0700 (PDT)
Message-ID: <001823d5-13cb-1b03-9ffa-686081123d08@kernel.dk>
Date:   Thu, 28 Apr 2022 09:39:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [syzbot] KASAN: use-after-free Read in add_wait_queue
Content-Language: en-US
To:     syzbot <syzbot+950cee6d91e62329be2c@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, gregkh@linuxfoundation.org,
        io-uring@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000765a6105ddb8a8b9@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000765a6105ddb8a8b9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: io_uring: fix assuming triggered poll waitqueue is the single poll

-- 
Jens Axboe

