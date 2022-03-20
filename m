Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722C4E1AD0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiCTJQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiCTJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:16:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC62676;
        Sun, 20 Mar 2022 02:14:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bx5so10763665pjb.3;
        Sun, 20 Mar 2022 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZtjwFSvgZdoHvpS1R74J2Mec4aRfjaVSNT59r7RniE=;
        b=UQoC4QgqZzB7+fqf97HxGKF2g7R8OE1RNGIcOGK7NPZQBb46nvCcwygsA0oMB430Et
         VFkbjTUhdPaX1MrulWLZ8/x458ac/fcQC1SpQxYz3/vOByyXIL0iM4h0l+i5xdg3lIR2
         EHsI2n/JD2y6vqhLVH8sEgMu3x5Hy017RIyqXW8351ofcsJhshvwwAxXtMnYaRirf0cg
         2qM/jQPUAGQhVlmgMMfcJJBfWQ33UMFtHgtti0Gfwpy93EKB9GF/raRPH+MZojjPjLfe
         aCatww+ik2KUNWWCwjQ0r4sbt1veNjskedAgvg89/I1KmU4t5uFL1jD1d1e8uM/AHaQ9
         oNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZtjwFSvgZdoHvpS1R74J2Mec4aRfjaVSNT59r7RniE=;
        b=De2oCHhNiqCvwdgo5szzlM+cgsdu0gCrGR6sJSct8JyZOaWovJt1M+f1y2ilA3ryqb
         gjbct1Vkg1u0if7g7QJv9uGk8heSmSX2D9kU1ysrNyBCZE1pIXAdG3QHgrthpNP9jkZ5
         OhmeKBV8KycvV4z51dly6vC6hdC/h9ULVZzn6rnquqW+uY7OoEY1rD/ZIxQADVgS629J
         AhbF/aLx7TXTGPdgjYNIAzhrlRh66ZhqtSgT0BX8VmQdC60GVuVyyAvSrYbGuxiBPw9s
         pAzCR4XhpOyClAloLViav1EYhcsVpdOM+HCTxW9ufeg+lgB4TrUWFER9JWmnbXvJFaw0
         TPTw==
X-Gm-Message-State: AOAM530RDIgs5Rj5BdAkt4M7qGjqXLgc7GLTsYxFae2OJusDCXRQp0mM
        HH5jExeP5WdyMCn6CQGmorg=
X-Google-Smtp-Source: ABdhPJybsiIaerQmBOFGDSIRjft+5GYWO+fJLPqiZP09CzaFELfQl1aODHduLNr8ncJkdUJJztehgA==
X-Received: by 2002:a17:902:d507:b0:151:f3dd:dd50 with SMTP id b7-20020a170902d50700b00151f3dddd50mr7725722plg.35.1647767683885;
        Sun, 20 Mar 2022 02:14:43 -0700 (PDT)
Received: from localhost.localdomain ([36.24.165.243])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm6909299pjl.3.2022.03.20.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 02:14:43 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jakobkoschel@gmail.com
Cc:     akpm@osdl.org, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, v4l@cerqueira.org, xiam0nd.tong@gmail.com,
        yangyingliang@huawei.com
Subject: Re: [PATCH] saa7134: fix incorrect check to determine if no element is found in list
Date:   Sun, 20 Mar 2022 17:14:38 +0800
Message-Id: <20220320091438.16329-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <86AD565C-ADD2-4000-BF99-487EF9FCDB2F@gmail.com>
References: <86AD565C-ADD2-4000-BF99-487EF9FCDB2F@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2022 07:12:33 +0100,
Jakob Koschel <jakobkoschel@gmail.com> wrote:
> > On 20. Mar 2022, at 03:57, Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
> > 
> > The bug is here: "if (dev == NULL)".
> > 
> > The list iterator value will *always* be set and non-NULL by
> > list_for_each_entry(), so it is incorrect to assume that the iterator
> > value will be NULL if the list is empty or no element is found in list.
> > 
> > Use a new value 'iter' as the list iterator, while use the old value
> > 'req' as a dedicated pointer to point to the found element, which
> > 1. can fix this bug, due to now 'req' is NULL only if it's not found.
> > 2. do not need to change all the uses of 'req' after the loop.
> > 3. can also limit the scope of the list iterator 'iter' *only inside*
> >   the traversal loop by simply declaring 'iter' inside the loop in the
> >   future, as usage of the iterator outside of the list_for_each_entry
> >   is considered harmful. https://lkml.org/lkml/2022/2/17/1032
> > 
> > Fixes: 4aabf6331f89c ("[PATCH] v4l: (951) Make saa7134-oss as a stand-alone module")
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> > ---
> > drivers/media/pci/saa7134/saa7134-alsa.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
> > index fb24d2ed3621..4955f7e7c5bf 100644
> > --- a/drivers/media/pci/saa7134/saa7134-alsa.c
> > +++ b/drivers/media/pci/saa7134/saa7134-alsa.c
> > @@ -1215,18 +1215,21 @@ static int alsa_device_exit(struct saa7134_dev *dev)
> > static int saa7134_alsa_init(void)
> > {
> > 	struct saa7134_dev *dev = NULL;
> > +	struct saa7134_dev *iter;
> > 
> > 	saa7134_dmasound_init = alsa_device_init;
> > 	saa7134_dmasound_exit = alsa_device_exit;
> > 
> > 	pr_info("saa7134 ALSA driver for DMA sound loaded\n");
> > 
> > -	list_for_each_entry(dev, &saa7134_devlist, devlist) {
> > -		if (dev->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7130)
> > +	list_for_each_entry(iter, &saa7134_devlist, devlist) {
> > +		dev = iter;
> > +
> > +		if (iter->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7130)
> > 			pr_info("%s/alsa: %s doesn't support digital audio\n",
> > -				dev->name, saa7134_boards[dev->board].name);
> > +				iter->name, saa7134_boards[iter->board].name);
> > 		else
> > -			alsa_device_init(dev);
> > +			alsa_device_init(iter);
> > 	}
> > 
> > 	if (dev == NULL)
> 
> I could be wrong, but judging from the printed message "saa7134 ALSA: no saa7134 cards found"
> and how the code is structured, I got the impression that the intention for this code was
> to only execute if the list is empty. 
> 
> There is no break or anything so it's not looking for a specific element.
> 
> It might make more sense to simply replace this check with:
> 	if (list_empty(&saa7134_devlist))

Oh, yes. I think you are right. In addtion, the unneeded initializer for
'dev' can also be removed because the list iterator is always initialized.

Thank you for the suggestion!

--
Xiaomeng Tong
