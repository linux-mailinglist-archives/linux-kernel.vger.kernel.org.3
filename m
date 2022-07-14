Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30357574D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiGNWAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiGNWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:00:31 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C16717F;
        Thu, 14 Jul 2022 15:00:30 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id w188so2563842vsb.6;
        Thu, 14 Jul 2022 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uqejFrrJQVrbf4+FczBPWjgqVBbsgKFGlzQ/n7XaL+o=;
        b=NTBavKrnx6m3woTqnQo5hRe7P2v2aO74raMvzzh7stWSrpiCJ83EzlympvdjZm8d/m
         3yznsW9R8LWrRn50menrhA24+Wp9/PmFw3rzkpiNLQmM04N7s55REOQ6C6bgPMcaaQkj
         v61IlqBR7Ekiu/Izu2oFBr0BMuQFwc8ao86eUCLQ549VjrdwfMolX5CI8jDz+ylXKwd3
         eD6vBjYQngGX93RmUY7y/jjam/wpBsZNyU9DiD3WRQ0O+/HcJjpuuz1wJa1rq81qoB+/
         x26m9Q3sgSTv6/4o6OGXGyjx9fxW+LWd/0X/c0UcREZjqvJPGrRMrukqv3s9/E5ihLIY
         HBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uqejFrrJQVrbf4+FczBPWjgqVBbsgKFGlzQ/n7XaL+o=;
        b=zkdvX0bzo02b5NqF7kLQQchqposFHcywSQ1nggyKGVbvKQtigvx6ftXmvWzFczqny0
         FH7Jwl8824jaNFu3dVQt+7QOhnVHIVwJgRI0TXoKtqnkBVmuZaQUIzhb3fRaoLZtFZiD
         CHES62QO5WbitKudM4rTGzkWzFlAc9iHHe2VBJtQcnzlIQxnsVIF+llxARnqPHn3ICTr
         QoiR2OYcED1E6r0P+9DlMqAzSH7cu9XqimNnMtA6J8ETA4GEPFbojxNt3x/PCfvkvgC+
         ZcblvZMw0iyprQTNHnyNI8kRi1pCotOeZv0w5hRYR1wkksyZoGcz+vnLSwd4QOcvgp8E
         BQVQ==
X-Gm-Message-State: AJIora8IEKv0s9kL8mrXa7GYYf+qZ9MrQg/A1jZoe0R9u2KD1IpglcCy
        667ROZI+cW6X63RvrJTNTRjahYwKDwzzHLsVdN7Vnl9GTAS1+Q==
X-Google-Smtp-Source: AGRyM1ttwjuU60+tMG8wmAHau//VSxupOkTakmOd/lYTN4MTpnx1ZfjU/hL6KefoeZYPT9YhJYzgSThaqTOaSkpLT/k=
X-Received: by 2002:a67:6d86:0:b0:357:3d99:ec77 with SMTP id
 i128-20020a676d86000000b003573d99ec77mr4596119vsc.6.1657836029630; Thu, 14
 Jul 2022 15:00:29 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 14 Jul 2022 17:00:19 -0500
Message-ID: <CAH2r5msuc3-1V+dh5NdwnE6uBoN+7_cf=m6kwrFrTnwArND0LQ@mail.gmail.com>
Subject: Is casting a void ptr to something else considered bad kernel coding style
To:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Cc:     Yu Zhe <yuzhe@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For examples like this where a pointer which is (void *) is cast to
something else, is this considered bad coding style in kernel C
programming?

It may be that leaving the (unnecessary) cast in, although it is not
required for C, makes the code clearer in some cases.

Any opinions on changes to remove casts of void pointers for kernel
code (which I have recently seen suggested)?

for example:

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -354,7 +354,7 @@ fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
               void *buf,
               unsigned int *total_len)
 {
-       struct smb2_pdu *spdu = (struct smb2_pdu *)buf;
+       struct smb2_pdu *spdu = buf;

-- 
Thanks,

Steve
