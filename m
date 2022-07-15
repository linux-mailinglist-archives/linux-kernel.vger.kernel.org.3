Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55A15767C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiGOTv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:51:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC646393E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:51:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z1so4032042plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aAEj2z5j4rN4w6X3AYcfh5DYvWwVn2tCNouMHhk/4Hg=;
        b=x5GtODR6djC4ltsn1mXT07cTWndraIHznXkvheaFSux28/X1CrrD5aDWmL/AwHY879
         zIhGL2Q1cSRZCFw1MYESrc1KeGsEvO3nBsgFt5GCmYZOFPNasUc/56QpqbScTlAXbr0Z
         FMivWGhV6ZMNRHxZ+sTbfl1kdq8bftf47HNlpfxjrGuaX65IX38edlu+tnGK7SX/4yN8
         swDN1TZy7Cqr5BmXNW4rmkDwgPsMGh1YSP2dMIS7RYjn/RE4G7Zo3UaPJ6FIobqhBMKo
         8anOQjBlhaw/a9RMYGQiGrhZ/2pOyDdccF1p1KuEAZb2L0y4I/13+MQsw63q/kwJYAaE
         kWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aAEj2z5j4rN4w6X3AYcfh5DYvWwVn2tCNouMHhk/4Hg=;
        b=iB7+TN2CJvgjjCq085cq/NbXH2Wxgar6b8kGALfHy+Qpy0J5sPoWRUaBbOsIByUoUD
         MBX5mZLDc6BUty9MGsaiJnLTWZAFF8ubvEUvx3yXzXNNIf3G5SwRkrK86/r8iZbqGLet
         Hlu/dAtJpm3jiHD/6SlzK9cU0kC1R7qyM29YVadSptUA52xWwg1DiRxbF9u5YJ7Ge8kJ
         Lm0rtx/c4Rbkv4aDB4+GBqeixeNOJ2x0gkb/7oYkXMmrproGd3pYuIBeQ4QA+xsj79TF
         I/ZIbnx7EPOo9nFThc2pW0t9Yl93isXxGXTvDHzU5ZGfWMvX7qdK4dLirEU8Fm/gqFqB
         mjKA==
X-Gm-Message-State: AJIora+iMiFk0rtJvFanQvYKb2jLs5JtsvvGGpUaA+gozcnVFWKLnBsN
        w4iShAL7823dmXilygP9Hu6FnO532bbLiA==
X-Google-Smtp-Source: AGRyM1u5R2xGXHm/wIzhsGKVgEdopo4Wk8YMYiEujVEhjpeUiDwtfTDu0FzwJ7TVLEhVC+DpZbH40Q==
X-Received: by 2002:a17:902:c102:b0:16c:acf1:60e7 with SMTP id 2-20020a170902c10200b0016cacf160e7mr10273131pli.93.1657914686557;
        Fri, 15 Jul 2022 12:51:26 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b0040d75537824sm3565275pgj.86.2022.07.15.12.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:51:26 -0700 (PDT)
Message-ID: <7e2c6bc4-8aef-3334-fbbf-d67e7de617fe@kernel.dk>
Date:   Fri, 15 Jul 2022 13:51:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] nvme: Use command_id instead of req->tag in
 trace_nvme_complete_rq()
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, beanhuo@micron.com
References: <20220715194804.324158-1-beanhuo@iokpp.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220715194804.324158-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 1:48 PM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> use command_id instead of req->tag in trace_nvme_complete_rq(),
> because of commit e7006de6c238 ("nvme: code command_id with a genctr
> for use authentication after release"), cmd->common.command_id is set to
> ((genctl & 0xf)< 12 | req->tag), no longer req->tag, which makes cid in
> trace_nvme_complete_rq and trace_nvme_setup_cmd are not the same.

Needs a fixes tag.

-- 
Jens Axboe

