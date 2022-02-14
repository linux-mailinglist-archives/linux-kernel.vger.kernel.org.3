Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF94B5514
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356004AbiBNPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:45:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355974AbiBNPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:45:42 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43124925B;
        Mon, 14 Feb 2022 07:45:34 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id be32so4360655ljb.7;
        Mon, 14 Feb 2022 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FztyKzv6dHpMb2LTGno+rYgClFz3GISrzuq2OrZ/IwY=;
        b=EqAR2DrGCWZ91yI5D95Slj+Hv/MWRuc+Qs8FANyKXabFHwOqD7XFM6u6msaoxC1VBu
         qfCmMQ7XGC7XPXzS89OEnNFv2MaJfVljKYFyWSyQ2zjzfj+bHHqbgd5WaacP6JkcpkdB
         8ECH4uiE+NvFKqfbejg+dib3ux/04rLuDvb0le0DY+vyX++PMK7boD77Suuk8mXcLNOQ
         fb4P8fN2ZDJbZbime1vfonsnKTs9RnQyCdJFxAHtsa1V3gtVF9/ImpIffz+LZhoolNRs
         6q6zOuhfbgizawGuN2PbYRQHspZf/7ZTZiv2kfrWWGHNI7Mx5TwSnzxu0phi3I1nCKgj
         PCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FztyKzv6dHpMb2LTGno+rYgClFz3GISrzuq2OrZ/IwY=;
        b=FVaIImMZ1B6xubx8vySEAWXfhL/IblIgxS/eNFSpJV9idAswQVrQk7t7WI0WDm8r+D
         Hxf2g0sQfSFxrGJVFLdMOvYYWd/JhoixQ/njFiLgvNBZcLtJyVVNiaCkM7tuoyAbzU9Z
         gJOcRAmoVuhMpm0dkZZHme6uKl8qskVGTtycd44uia7NUHMlSVmG+gV/pJRywoTMAWtU
         6ItPO15YEG7WZtrZFIHGHTTAFVyTPSLzCzFIK9JjB618L6wjaIU66053gx0LrGBwBCEn
         wPH0nN2Oa83UE0HKQVP5GRPZGuATyejwDS2L9A08JxOsfKQQKYGuoFQLhTCG5AmTBNMe
         L6RQ==
X-Gm-Message-State: AOAM531BB0gCInR/N6JS0qK0rNPWW8UKmT/2/4oogIEfqiPdNCYxFXmS
        YrwHZgqYywDZ8KInniuhQN0=
X-Google-Smtp-Source: ABdhPJxpkWABFSdPJOyelxvjRIAFbTf6BXxGaSHaa1Yc0Ah+DCfx6cpknNQBu/fNNUq7b7IBE/G0cg==
X-Received: by 2002:a05:651c:2051:: with SMTP id t17mr219765ljo.207.1644853533194;
        Mon, 14 Feb 2022 07:45:33 -0800 (PST)
Received: from [192.168.1.103] ([31.173.86.214])
        by smtp.gmail.com with ESMTPSA id t15sm376002lfr.72.2022.02.14.07.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 07:45:32 -0800 (PST)
Subject: Re: [PATCH] xhci: reduce xhci_handshake timeout in xhci_reset
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com, Jung Daehwan <dh10.jung@samsung.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <766b6370-979e-cd3c-cb64-44abce1977d7@gmail.com>
Date:   Mon, 14 Feb 2022 18:45:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/14/22 2:04 PM, Pavankumar Kondeti wrote:

> From: Daehwan Jung <dh10.jung@samsung.com>
> 
> xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> controller reset and controller ready operations can be fatal to the
> system when controller is timed out. Reduce the timeout to 1 second
> and print a error message when the time out happens.

   Waiting 1 second with IRQs diabled is also hardly acceptable. :-/

> 
> Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
[...]

MBR, Sergey
