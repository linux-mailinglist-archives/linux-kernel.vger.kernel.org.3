Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C60E5035E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiDPKN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiDPKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:13:24 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EEF47D3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:10:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t15so2709688oie.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXXQ+U+tk4JSfC1gjVM3Xbh0G9pUMtcnqO0SSYt0pko=;
        b=STPo7oWtCQGs3gAUCj90BeZahvQdrXOc666NI2dF+jjdKYwqsQ7v41qKkF1r5/VmQ9
         oBOa7kdd2CbSD3MAfuIjK52irzYW8LXeV6bao2Z2RJ7hCH5BZ1jOjsHw54bjMaCgTYuQ
         EBPGy67Kn2apfplRaimWr9vC6AXsZB1vFEcinWUb/glKuxjXlE0HfpLa4ZMStV3/0Jk0
         zrVRw6D5j9YraYGJZmqJiVjTgdrE3pHAZn46uiXvF8xHFUymDBj/sPXzy1wuQIW5GTzV
         o0K3fcumXxyjwuWvxwBLNjPLDtUSfXlKSy3ea1uCrZRFdAJn6A+07P6uHdyFip3WopCR
         PFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXXQ+U+tk4JSfC1gjVM3Xbh0G9pUMtcnqO0SSYt0pko=;
        b=nA6/G1qooR1vjbHkP5rRiYiZasCYPjCpn4lKzVyxRPHK2I9y0CA3s5MCfASdKskeBQ
         beNPSBkWD+iNZhH6ZxFhIEIf/qfqNFBIKd/ColecQTkzfDKnhsZ7j9CDciHIiJqKoMxd
         zM40n2s9YNtPTFTDXSpez4Z9dn7bcIuYlP0zRDORIlVH2h7Bu1Zob7vhBg0QdSwOUulM
         GBBaFWYafuvVfsBGqmgnWOlFgiDlgqD69ih9pfv0WhPRqpw0EvW7E5pVwBtbTOSn8JUb
         qDmmrkIKSECtlNi/u8eIRvb8oS/QiSHe2mBVdyE6lkETJ+pPjJOkt7oyaTsVNoPfpqEr
         ZSMg==
X-Gm-Message-State: AOAM533rVWGi1qB3fgOiOgM01RW49WPFBZT0IY/yriAUBKshwpe3MKST
        IX9o5ZZEjLTvSJH2jPv8dy8sSs8RsZ/19n4wfTk=
X-Google-Smtp-Source: ABdhPJwErbIxWFTJas7LYVag6rDpUS0BW6A67CjZ7Be3Nkh10XkWs28CGVYWGGDMO0LrouKjDTJvVNA1QnTxRM2aHGk=
X-Received: by 2002:a05:6808:10d4:b0:322:2f79:bd2c with SMTP id
 s20-20020a05680810d400b003222f79bd2cmr3224781ois.53.1650103852247; Sat, 16
 Apr 2022 03:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220415034844.1024538-1-gch981213@gmail.com> <20220415034844.1024538-4-gch981213@gmail.com>
In-Reply-To: <20220415034844.1024538-4-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 16 Apr 2022 18:10:40 +0800
Message-ID: <CAJsYDVJsJqCdMG54p_1hRrCfH23bMu116Bqs7KG8WM9MAN1hZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mtd: spinand: probe Winbond W25N01GV/W using param page
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>, linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Apr 15, 2022 at 11:49 AM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> The JEDEC ID of EFAA21 is assigned to both W25N01G and W25N01K.
> Probing the chip with JEDEC ID isn't reliable anymore. Use parameter
> page instead.

I just found an old W25N01GV with no valid parameter page.
I need to rethink how to deal with this crap then. This patchset is
abandoned.

-- 
Regards,
Chuanhong Guo
