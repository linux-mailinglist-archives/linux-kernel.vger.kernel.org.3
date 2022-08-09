Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2977B58D16C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiHIAg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHIAg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:36:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007312760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:36:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p125so5952606pfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 17:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=a/4gloR0juBdlHHYNcJlbW/FTcwo8LAnogSl5yyVZ1Y=;
        b=Qd1JgbOfAQNNkH2ORrSMNQ5Hz4GYqKxE6fcYDw3qmHkJH5xcda/qjULZOLi8Yh8fA5
         PX4UJcXc1GpZleJAwkkKWTg0TrA+g5HSpVYLnyo+gIo4rUvSDSuyKy5x9n1xza8X5Vp+
         jg9oMmtRuuiBDWU2pA9e071NnCUTpVJ5R7H9+u9rxmsE9rJinMf0HR4WvlqMSvaRtll3
         cANxEoezLIyL9tIkQr84jQosUCYuv6m1Gn3j6G14K/zI5tk4Ovt7Q6J64bG1nMs3fmVe
         Ji/5nMH9QiMltWsP+MpoREAP5S3/DXrzX6H8avLaRRKm039Asf0ZM4WZ0A4jwpDogp0u
         fdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=a/4gloR0juBdlHHYNcJlbW/FTcwo8LAnogSl5yyVZ1Y=;
        b=PmrOtsi2qy/Jw0udkpYZ3QLH84jxEOzz8FGH0qh7OBbyIBxGnhEo9rNKXbY/kuSITl
         VbNadZlGdT9W7raY3HLh3x9qsVyQqVVP1FcpqEouWbDtfchKF7bpOVQWQcL5e1xEej/1
         YqK15sGcX2GZGHXYwH5zcfTNd6gUFo/UbxVlZtr+qMP/dyz7WBwZ7bpspinfQ9e5bcqv
         jBb2egWAvzuYQlTtVbewjHCvVvv1+BQ6L4ND2Db2n0GndT1YzreCZGfwEQHGX8ND6wbA
         We4eOdcr0DrqOtRYsBNTsh+sRPLK0e19jk5iMbILzN3PMjmaRw66UjElhwLhFXTT9m1K
         pe5w==
X-Gm-Message-State: ACgBeo0k+JjB2rc2ASt0xyuZDXMvMBjtrgX1Oxgf+zruEgVJxJX9RiOQ
        oPxL/Xygaakyhb2RuHUrWimSVw==
X-Google-Smtp-Source: AA6agR6I9AqcP5FN+oFJsgJk1bziGLbi1GyQZllwCS+9VU1jyl56wRMIelcm1R7MYNSCzPlx78Ksww==
X-Received: by 2002:a05:6a00:1706:b0:52f:6f75:991b with SMTP id h6-20020a056a00170600b0052f6f75991bmr5124904pfc.34.1660005415453;
        Mon, 08 Aug 2022 17:36:55 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090ade8200b001eff36b1f2asm8804317pjv.0.2022.08.08.17.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:36:55 -0700 (PDT)
Date:   Tue, 9 Aug 2022 00:36:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Coleman Dietsch <dietschc@csp.edu>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 0/2] KVM: x86/xen: Prevent Xen timer init when running
Message-ID: <YvGsIwSwMdt7BRXL@google.com>
References: <20220808190211.323827-1-dietschc@csp.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808190211.323827-1-dietschc@csp.edu>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+David

On Mon, Aug 08, 2022, Coleman Dietsch wrote:
> Coleman Dietsch (2):
>   KVM: x86/xen: Initialize Xen timer only once
>   KVM: x86/xen: Stop Xen timer before changing IRQ

Paolo, can you grab these for the current cycle?  FWIW, I believe David's ack still
stands too.

Thanks!

[*] https://lore.kernel.org/all/9bad724858b6a06c25ead865b2b3d9dfc216d01c.camel@infradead.org
