Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D959F878
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiHXLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiHXLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:16:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808547EFD9;
        Wed, 24 Aug 2022 04:15:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r141so13080815iod.4;
        Wed, 24 Aug 2022 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PZxnpfSJMvALoRdhc1rjgyP+neDe3p1h+kJbSmrA/UI=;
        b=qVt+O5IwDlPReN2t/CDwMBiwOsGs6FQX3my/O+13pBEFOHsixwVrs/9LzHq0yiVceO
         MYBgmK+b+WOOaGaymS8YV73wVW6tlbqGa13CnpI2yKAAFsXq/6q/a+PmV2WjDr6OMyrp
         UeVlgbJxaQGoClBJ5QUa5nSN4HRBwbGO4ZL+EKC54kBHzirL6l6DT8smNYfEm1Rix3uf
         +/8J3X28B6RNUZP3mBoRx+iKSkwBtx/Y3lClx87FBq/2nGnOg+Li0/3MoWrbLiFSfTL7
         4mvF82lMp0zRUwGJRt9KupTnVCZy9frP8LtvSTVf+4YRmQi1iiGbyplP73GKjvsQ17KE
         QmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PZxnpfSJMvALoRdhc1rjgyP+neDe3p1h+kJbSmrA/UI=;
        b=5zjeXIsgFFSSolcYE4VxdPP/6b8T26JC7ALj6rsP/5hfmUxBKYhUE7ko/DFVBm2EAf
         O1N9VVBCKvJnUh1nk1rMouVDtxl2UxhVjS/lziO1PCJWyxaZ7b0QOZvnUUZTPOUt+A9d
         tbUdAIEt51kR/jpIE4l86bPJzdOLqpoZvWL6w+tdkAl9oWMYgOQCBFaEMSH9FDB2MPYI
         a9RjMmPyn3Yggw3pUxIdB1yorTDfljNsFiMj5yw5BemulTo4fC6uCt/h/KRePZ7aYtSc
         +uI+44Q6IKoEfFenBCnfzGBjMR6PopqMXWb0LVUAmHLjH7V+LZH6KMXEh/lhP0YS4D9r
         YDPg==
X-Gm-Message-State: ACgBeo0AM89MAfSk9zjHH/Ecs6fB1FGUoLB98y4/HcH1bWBmeOEyVPhE
        /TNrGECqL+VkvdutpPnw7hsCnO4mA/fBzIOQ+lc=
X-Google-Smtp-Source: AA6agR7GNHFQIgqqNPPpcd9UPHbtLc1RI/FzKqPkNMx37aeCko3TOqVwIGTc5alSaToIjlmGg7RmmWhLzgBxGT3Crmg=
X-Received: by 2002:a05:6638:d8a:b0:34a:1212:faa9 with SMTP id
 l10-20020a0566380d8a00b0034a1212faa9mr157043jaj.51.1661339757994; Wed, 24 Aug
 2022 04:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
 <20220823182758.13401-2-khalid.masum.92@gmail.com> <YwU2vp0FSR5dS/FX@rowland.harvard.edu>
In-Reply-To: <YwU2vp0FSR5dS/FX@rowland.harvard.edu>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Wed, 24 Aug 2022 17:15:47 +0600
Message-ID: <CAABMjtH7q2evZ4R7FGC8m3a716ec9+e8+KdmrvnqB4_r6rF2Jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: ehci: Prevent possible modulo by zero
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 2:21 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
>         if (!ep) {
>                 usb_free_urb(urb);
>                 return NULL;
>         }
>
> Neither of these patches is needed.
>
> Alan Stern

Thanks, I got you.

  -- Khalid Masum
