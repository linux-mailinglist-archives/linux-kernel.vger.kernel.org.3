Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F655550F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiFTEew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFTEet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:34:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71522D116
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:34:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so4511123pjg.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZwqahDHThWPbCSkd04LkEiVlXEdscZb913LydHKUXuk=;
        b=Y4b8o/SvbiJj5yXOw/uFM2KaEq4hLSLtkrgNsAUTmWf3BqPAm3TfIppnQFfZemf+zF
         IMh7SaiMY0+2s7YvwjCDLR80REUPFfFoWiZnHbeb1pHc1QIi3pyrKElWuR4mwXheaEmO
         dHWZ5TadCHmCE/Pa72NIX12Z8VzpqdAi3VLPlnZzN8YZCnmugqs2ysNLce6WnMf9Tn8n
         BAzSG7OSwg41Jzr8tIYPKJqLFaqSiBwnvG5TnXAWGqMgiSXxVaBU/UOlYiVWi1Xyw0ab
         DW8CQyrgIfwIEaEksnxUO2FUNFyCu7knFQY0e4oREQ4lZI/XtIQju0YafC0qGf8qcuG0
         9LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZwqahDHThWPbCSkd04LkEiVlXEdscZb913LydHKUXuk=;
        b=ZkLY8THqX0BigEqpieQGB62kj974mBvS9TfhRBNOLxqDo9/UaO0bO2DgV0u/T4Mwnq
         ar+sQgHePSLIVg4qLP/XJGkLwoEx1LoqeDsVi90/ihGP6oceEc2H/qy5LeiCCMFd+wL0
         b6GyxNr0ehziH7w0iGMfznXZ9bGAxMCcF3MmSOzeSnEttk36/DSwSp6raBZmZH+eRwj9
         RVjijXb+I2SaT1KlXUubL5WKql4uth7h9I/WOm8+Jvt6lJYAJqqIA0dT1YqbCh3tglo0
         6Nug8/M5Ab3M27amYUWlDwo545l4jhgC8uWmuEa/R9M8QDiwS1U9A7MGtKGRts4OBd1y
         V0fg==
X-Gm-Message-State: AJIora90p3cvPW5uZW7E318KMI4VXQwgHCJ6NhcJDEHFKN9cKnq8/uGz
        tXJrpvqEhN1VmzaIde+T5ts=
X-Google-Smtp-Source: AGRyM1sLOJK4GdbtT38Rxr8D9tca0o+Up1SX9oAhXVi9naycP0yEUoILLaD1ayt/I1XJfpH1QBc7ZQ==
X-Received: by 2002:a17:902:f707:b0:16a:176b:d75f with SMTP id h7-20020a170902f70700b0016a176bd75fmr7888495plo.158.1655699686944;
        Sun, 19 Jun 2022 21:34:46 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id p9-20020a62b809000000b00522cae827f6sm3541984pfe.197.2022.06.19.21.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 21:34:46 -0700 (PDT)
From:   SungHwan Jung <onenowy@gmail.com>
To:     hch@lst.de
Cc:     Jason@zx2c4.com, abhijeet.rao@intel.com, alan.adamson@oracle.com,
        axboe@fb.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, monish.kumar.r@intel.com,
        pankydev8@gmail.com, sagi@grimberg.me, yi.zhang@redhat.com
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR observed during blktests]
Date:   Mon, 20 Jun 2022 13:34:02 +0900
Message-Id: <20220620043402.13202-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615113106.GA10697@lst.de>
References: <20220615113106.GA10697@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,
I'm sorry to send mail again.

I think it would be to confirm that subsystem-ids for all X5 model and these ids are not used for other ssd by contact with samsung.

But I have no idea how to contant with them, please fowards this to them or if you already have these information, please tests the patch in previous mail.
