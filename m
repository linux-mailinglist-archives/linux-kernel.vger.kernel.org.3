Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A254C113B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiBWL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiBWL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:27:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B53938BCF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:27:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g39so30426747lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=vPyJuAf88myS7si5WcR+zzfh8HnXlbMVH6oIBvug8tI=;
        b=UqLvYJoTi5ddiTkA4j0CM0QCdyIxz6qClqQgMk/4ddFLkimncoMhxKGYAnxsGIHluY
         uCkT+oc1lurVlRab923X0MWtaVtAOuyWNkigH3Xo1QMW4jBy9fEhRT2hBTmAc5nEktqC
         u1IkOWjY/W6nUasJVGndlmCGsJ6iFBEkV04GNEiAkph/Y+RMqnPnY2vywYxbg+0UJ8SB
         EKYWu5/DqVhi2fhmYqY1g82YIPIgWWmpQwMZGGZsSemIo8AiAQtRM1FR1hsaLkzYtTgf
         d4k2jW/baYhRq9MOmL0y2Hx2V+b7eQ5TVsLs/hLFcFfMcmrezNlXiPFT0PPr3NKweNyx
         RhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=vPyJuAf88myS7si5WcR+zzfh8HnXlbMVH6oIBvug8tI=;
        b=SPRBnDYe9+AMaUfRxvQrVqFzwZ9l4iGZ0nDkpeK8x6PvBnqNMnRo7G0itDD+DDuL3l
         fzWwLJQt8qisFQBLS1+gumHDCBj54sGHBpFav1g3gUcAaxrNOQ4YONZklMahPLYYj+JW
         JtmA3KUuJxva7+05AP7WrnGmtTPKCBy95JRe1GlJodQ3H2nY3N1w8u9YRGD4rFjm+ph6
         6vbat/KGt0vhBRhwgtdGeuBlXGNKlt101YEovPtwsbvuV6xyvrG14ScLBWyZZlXvOxjt
         927YBJimGS4gkqNLObaP3tn5a0b8Y2rtAJDOI9OxINorb59Qd1XiTPMLLoXSFKzDZwVc
         xclA==
X-Gm-Message-State: AOAM532xdFI797d8UOUaDYTSA5xcNoAzPZRcAYSBK2aHlDmN7TPkSc+4
        fLdjJJTC1wOWu36pHAgHg/S7YjucELUTDg==
X-Google-Smtp-Source: ABdhPJx2gZHv46TNk5w/E+jP+2xTAixpxHt0WoJzaCTH92y3YKVnBZPZufjLB7XLlsTbRV5RqZw/EQ==
X-Received: by 2002:a05:6512:3c9b:b0:440:10a2:dc11 with SMTP id h27-20020a0565123c9b00b0044010a2dc11mr19369660lfv.584.1645615626569;
        Wed, 23 Feb 2022 03:27:06 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id z9sm774383lji.29.2022.02.23.03.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:27:06 -0800 (PST)
Message-ID: <f1898870-23b8-3c13-01ed-854843043279@gmail.com>
Date:   Wed, 23 Feb 2022 14:27:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <81102f38-3e1f-ec36-3119-a098bd5a85c4@gmail.com>
In-Reply-To: <81102f38-3e1f-ec36-3119-a098bd5a85c4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/23/22 14:23, Pavel Skripkin wrote:
> you should use '#syz test' command to ask syzbot to test the patch.
> Basic syntax is '#syz test: <git tree> <branch or sha>' and syzbot will
> apply attached patch (if you have attached it)
> 
> 
> More about syzbot interactions here [1].
> 
> [1]
> https://github.com/google/syzkaller/blob/15439f1624735bde5ae3f3b66c1b964a98

^^^^^^

I've copy-pasted something weird... Sorry about that. Here is actual link


https://github.com/google/syzkaller/blob/master/docs/syzbot.md




With regards,
Pavel Skripkin
