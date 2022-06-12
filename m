Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495BB5479D2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiFLKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiFLKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 06:46:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3E1929D;
        Sun, 12 Jun 2022 03:46:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v14so3860873wra.5;
        Sun, 12 Jun 2022 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=L7wZV8OxqYvAB1GlMd0evBeabIpJY4/r3rWWpYVpI+k=;
        b=j5d2ONoPE99ch9Qamp9mZJ9tAlkbgXFGiyti1lJQ9Orcr5mO65tK0YNRGsJXmztmF6
         FpAazgaTAhGgBs085+A+z1OCgdJ8Zm6mhuzCqGJGGo4BTFNZaBD9hZsM4PieOZ4Pe6Mj
         5th68YqiO6JsSZJasJamO5Lu4dFGmOTOf/XJD26oSna4H7/u2xIQCTmoDBUf2P98Nk60
         Ha1GqFVryGEDwBJUh0yzGsXPAo0wN3+ltg97fZX6j/54kAO7B/TxDaTeBhFqkDf32yRi
         DiQvrtyiURqZbchBOGTT56qatDs5FyHczH0t1FhtiMMNR2h9pFjkwZGOX2TeI/SxAxc6
         70IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=L7wZV8OxqYvAB1GlMd0evBeabIpJY4/r3rWWpYVpI+k=;
        b=H79z13AA8oNyhehPBCRRUfJxfGstMwxnLVNsQUViUcJBsaNckaGT4miqPict61Ea50
         fv8H1afS2/T1TnjHaGbYWQSijlqfVUeprNHri4PJhywV0dwOHb8uNuRZfVFNs0BPLeks
         LPATCcyIy5wNsQWWnb0kKw57lE9V8Wi9/DaSthOXgyBhwA+pJK/p8T9m2Dmd8Aduwwyt
         QWYq3VOcLD2qym+uf+0uD0nINJZd8rsJGgIS7WZEfg9r3wx/jKUaiDGXELG3Rb+NbkW+
         4F1TqGP+WVT+J8Gk9BRJ8uQU2zb3JPjEpA/jOjxh8lsFtyncbFFTc/n+ip6lHO/lIrRq
         EwQA==
X-Gm-Message-State: AOAM532Issi4eokCI009iuhGsVD0Ps3X2XRowZjLIYByntMXZ72+Z5T2
        iDR7l4ouR0u2dTMEUpOVhofcHcV7TA==
X-Google-Smtp-Source: ABdhPJyfWcMdEp1K8Uu+ys4Lw7xJjNCyGiGgBhas1dUxVlhMcbo7zp1LDMCe1/zadnF58H4i8bXJ4A==
X-Received: by 2002:a05:6000:1f09:b0:21a:5f3:316a with SMTP id bv9-20020a0560001f0900b0021a05f3316amr805820wrb.682.1655030799648;
        Sun, 12 Jun 2022 03:46:39 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.224])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0039c4ba160absm20880712wmq.2.2022.06.12.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 03:46:38 -0700 (PDT)
Date:   Sun, 12 Jun 2022 13:46:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: Fix selfAssignment cppcheck warning
Message-ID: <YqXEDCzsYvDKsgQa@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -33,7 +33,8 @@
> #ifdef CONFIG_STRICT_MODULE_RWX
> # define strict_align(X) PAGE_ALIGN(X)
> #else
> -# define strict_align(X) (X)
> +/* OR with zero to avoid cppcheck selfAssignment warning */
> +# define strict_align(X) ((X) | 0)
>  #endif

Can these myopic tools be taught to see around and notice second
definition which does mutate variable so there is no self-assignment?
