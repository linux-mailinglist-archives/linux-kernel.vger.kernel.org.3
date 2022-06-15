Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93EC54CEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354494AbiFOQou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349857AbiFOQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:44:46 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C76344DD;
        Wed, 15 Jun 2022 09:44:43 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so2695399pjn.0;
        Wed, 15 Jun 2022 09:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kUAumrNxy9ol1zaZuiJOiPYZYAG7wSgZ7GfHMP4o9zg=;
        b=hdKOMKix5XjzZTycxNrzw6KSLy+Iap77aL7EhyNCW/NqMaDV5UJUU4wf6Q3MYjocxH
         g12ljWb0pon0YqIOJVcjhSjNGEuD+QYIIv4An020DSYvEnhYbKqaofhAc1WvqVzHI5NS
         hdGPSuaY6jDldLksabYegmjiZjCGG4zZTpS2jeJGRdNlwwWHQrSq/NUh3+/2lWhCT46K
         6ZtIH5Pnwe6+WV0RHvLNX8BgB+qhtV+gnQ4mrgIfvGDa0BVmcpjNYI05j5vd/8kmZ647
         Nk3MKzOftiBsglviTEkNk2VpF4QTNFDtyS4JUfjrW0D3VYt4RxtjHkj1He/o5vwWWP8V
         DQyA==
X-Gm-Message-State: AJIora9adyXnwaaNHK15irSSjKRFHOd+Izuk0YNSm3wH1aMHUlHKYO7V
        reSSxxdm7o3IYZUvojuUb0w=
X-Google-Smtp-Source: AGRyM1v7oIEWB19AQ13nJcIdZrr6DMAQ7CQU2vZbr3hHDuFqu1vNaK5V0c387/P8Wx8AOR4JUFugUQ==
X-Received: by 2002:a17:902:ecca:b0:166:3e34:4d01 with SMTP id a10-20020a170902ecca00b001663e344d01mr429867plh.97.1655311482526;
        Wed, 15 Jun 2022 09:44:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id qa17-20020a17090b4fd100b001e0abbc3a74sm1978772pjb.5.2022.06.15.09.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:44:41 -0700 (PDT)
Message-ID: <a4d5393a-2bb6-3fcf-0d79-18e6b6057628@acm.org>
Date:   Wed, 15 Jun 2022 09:44:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 02/10] scsi: ufs: Fix ADAPT logic for HS-G5
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220615035146.20964-1-stanley.chu@mediatek.com>
 <20220615035146.20964-3-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615035146.20964-3-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 20:51, Stanley Chu wrote:
> ADAPT now is added not only for HS Gear4 mode but also higher gears.
> Fix the logic for higher gears.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

