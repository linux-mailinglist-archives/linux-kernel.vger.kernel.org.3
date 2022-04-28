Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96556513B40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbiD1SR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbiD1SRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:17:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2828BB0AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:14:09 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y2so10482092ybi.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=gbsM6vlDaLwoBlkuciQ/cpPiZhcYl8M3ZfvVTq8SmXxnAEUdkygAm9kKjwfItUMhT1
         MA3+um8BbJ30OHZMTkO24+elO2g+xv2wlDKXFzaRms9Mx+2/TcX6x2UqEzyYuA6QN6OX
         NtLlWgst7jANzrKb6LedsJzC43Owxvcpk/A8nBIF4czbHl4fLtWeRVqwwzNLle9wG1vN
         V2AnK2FRSC/h/BYBNywV818tCHeLyIQj70NbDsSMkHi1gzzvDK2ZiPO552769dy637X6
         89aY9ukEi9zWSt1R871Cp0z2nZ5pYmCM5rsqB34T9CD/gpOMz1qfjXwWZHy0N9dwQaxq
         hpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=Zz73l+GmLeUC7qJf1oWDJ1PIUqh1LqbJKDgb11avoltFXroLYssMzy0dOpGv6l1YeY
         qD4yqtSldd92vaMn0q4s7Z04ImXk42/V00+3Np0iiQn471DBgmJpQQH2S1kmFnvUIGB7
         febAw7l/fYZxVOx1B6yWDUo0KOLAgTWaqcf1tatK8JFTade9wIaNpdRa9Qk0EZ5YSHWI
         qF2Td8l9aESZNzdnDzsousYLyvMZOwmmTqzEC0fG9jsc2zH0IUot0MgHVA1UYfaNAIWu
         ZdJT5ojGHFiuLH2hyguQBytRy37hOiJ6g3G1mbKWV4X49yUWcQ/n2+gb3Kc+HpKiRqRI
         RabA==
X-Gm-Message-State: AOAM533Mi6lQf1iW0XZ2QbuiNgcy2Z7GKB6iIsORtEBg2zpd603mOHNG
        MrYNQv+cvNf423uZRg96n2tq9Ieyhf8GqI90Wuc=
X-Received: by 2002:a25:bbcd:0:b0:648:d58d:ed4e with SMTP id
 c13-20020a25bbcd000000b00648d58ded4emt9006682ybk.646.1651169649100; Thu, 28
 Apr 2022 11:14:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:61c5:0:0:0:0:0 with HTTP; Thu, 28 Apr 2022 11:14:08
 -0700 (PDT)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAB+02OF8uUaEENbtu3oTZjtB_pHp9Kd_mzJ2JyeEHSkaxWzRkg@mail.gmail.com>
References: <CAB+02OEf2d=2V6VH=n9vhwKq=KuTdgPJ4dLc6MMhbcrC7eJ4dg@mail.gmail.com>
 <CAB+02OF2vuwGc6ob8VJCbhc21ZhxJSOzjO2BtAg29wrE4CVgzA@mail.gmail.com>
 <CAB+02OFDkWAkC45L=DU+KH6cFYkKqwzxMyjWPZoCdKq-c5i9zw@mail.gmail.com>
 <CAB+02OHKM6tqv_yzPMm81bPOEj=prFwEs8YJOmO9Miv_Ot1vZQ@mail.gmail.com>
 <CAB+02OHrFeERDHoZVB9upxki4p3Akrd56bwqmQ1VZy4Qnu-D_g@mail.gmail.com>
 <CAB+02OF74q2LVoq=ax+fzAgqWob9ofBBUaxsdsysv-q2Q4Q4oA@mail.gmail.com>
 <CAB+02OH_7xFE-hfaPLg7Jn_9PYKiURFtciK+zCWCKwfaABkhUA@mail.gmail.com>
 <CAB+02OEQNXwbX1i0PFTQXTbqQBYBVyhMsiw9hebgD5M9Zjf-=A@mail.gmail.com>
 <CAB+02OEMGMM7dX=KdFDKGqRQv3b9TiLxiwjM=qGua6LJRZvXeA@mail.gmail.com>
 <CAB+02OE7RNEhW5Upc+xY24yfiCGiuRMfbnry_UsFptxU66O5SQ@mail.gmail.com>
 <CAB+02OGj_c4Hv-R3E6UEWLyqWSdzi6jpSDmTUsyRwMbfMXeriA@mail.gmail.com>
 <CAB+02OFKxJfjHK7nYrGfxOd-harso-9tOT=Rv2NniXoNpC2tHg@mail.gmail.com>
 <CAB+02OGpU=8JYVHHActhQ4CHURnoUXO=ufcxbrV=1d4-7yTy6w@mail.gmail.com>
 <CAB+02OFG3+PFDH=C33+yA6pUps--FDNMfWsSOF3Ak6SAhetOGQ@mail.gmail.com>
 <CAB+02OHkNOxKWG7+Nm25eJWE6V5MKxgiDA_GFmDNXfOVL7nG4A@mail.gmail.com>
 <CAB+02OE4tc=Q2Ku2WQ=h2QD-NLjeU-Y+YHRsCwMRmCGgB0WUCQ@mail.gmail.com>
 <CAB+02OF4s5rNJk5B_1LiiFNXDGt2znZ+1F4qtM9UTpEp_FDA7A@mail.gmail.com>
 <CAB+02OEWqX9gabbs6eOd77hWYKWztU_MmWpPUEH+t0GX897W0Q@mail.gmail.com>
 <CAB+02OHyCyOzngWCfPXiScKHsTCJLN4Vvne2Vr7wyWx-yt3rmw@mail.gmail.com>
 <CAB+02OGDwDKoWk7F_BOuc0s73WYzgPCZp3PLJrxVzFr_Szcqgg@mail.gmail.com>
 <CAB+02OHTFDtXHnxsywDKmEG5c+pzWO-x_ocUwGHd2-gjbRsHNQ@mail.gmail.com>
 <CAB+02OFVTTD2CPDjzw40Gw-h9NmLTFM5rKJ4-8yioqCNauhkew@mail.gmail.com>
 <CAB+02OE32bfjUiKMSZpK2pduCE6uYRH_iQcn8qF9ojjjcnRzEg@mail.gmail.com>
 <CAB+02OF9qzYvyg7Xy0h=CvDEsfOirMbbvz+5jdG5ehM=baoS5g@mail.gmail.com>
 <CAB+02OE4GuPFhboqz7dVOVvi64frWiSKZsjeR8pXQqLDKuS6ZA@mail.gmail.com>
 <CAB+02OEJeMW_2_jyfqZumyj6WzEtRGx6hH6shH5+P24pVgJ3zg@mail.gmail.com>
 <CAB+02OHfgVNHYMC_ww6e1R0iQrccQ=Q684Lv-ZqtzD7g49A_=Q@mail.gmail.com>
 <CAB+02OH3r54arAAvmR+=NU4=tMUmm3xqpmCe-O2oN=naPKpg6A@mail.gmail.com>
 <CAB+02OGHPanhuZe3A=SDMX7Wy8oHMss7jB_xnR-m_6n21fkx+Q@mail.gmail.com>
 <CAB+02OEyjrq07P6KQrqcMjYQVDh6KAAtV872Cs3Yt=tCOQmhmg@mail.gmail.com>
 <CAB+02OHJ-WffAisOFyJUJ4DWgLn+_4Wjsa_=HVfQb01zniqhkw@mail.gmail.com> <CAB+02OF8uUaEENbtu3oTZjtB_pHp9Kd_mzJ2JyeEHSkaxWzRkg@mail.gmail.com>
From:   israel barney <abasszakari0@gmail.com>
Date:   Thu, 28 Apr 2022 18:14:08 +0000
Message-ID: <CAB+02OH9Deh9YwNrehvbf8vAKcacxm0Dduae-ovb_cX70Qe=HA@mail.gmail.com>
Subject: HELLO
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you! Please did you receive my previous message? I need
your urgent response.

My regards,
Mr. Israel Barney.
