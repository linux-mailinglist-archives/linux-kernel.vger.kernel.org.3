Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585E4B2ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbiBKQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:45:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351700AbiBKQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:45:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74121D68
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:45:31 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u12so5100707plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dFXJ174/FHjksMgNtUqWugIkgOl10ic8u3Hye+5cX+c=;
        b=YM/qktxwg58lxRejUqZuM+1MRPwM2m6VurqVzGgAbO1zxTIYMgnrhnBS9beXDliQsT
         kpLM29GY0tvK1TzYqkcG5vnZtGcU2eTdVR3xdVhLMNL2g/Z11yxZdJv8qm9bx8s2HUoW
         0yq2Ru37y0tDHpukzg7fJEAEF4sn92Uedeo4Xlu5PHLN/DENgNAWLy4o2eCm5jSEo3r4
         ikqOw0QoSKLttaXbeUuGfs4L7BynQ6CXkgXNGDngpBZqv16B2VPKocCNOubZlZBEn9jS
         2EuYpOpoIhw4fOR1kbDt/J/zwD8cOO2Puobt0Ew2nRNSlCEPg5eBYyi8fwxnq6slpJYO
         Yd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFXJ174/FHjksMgNtUqWugIkgOl10ic8u3Hye+5cX+c=;
        b=4/BafXIHxgI5rjKR+AqgIAA0wOzyhxOdOjwr6MB2U5xHEBMHtYURs2Mlj35M8xTVE1
         3i7ERvyiI6ltSyvy5Ar/lrxaKz5mW1hq+CCnlKqxsxRitCc0TgH+xTpExxzt+0hl6Ozy
         1bbXk4W3Mt23AnvNfaghWhXggjVpp7W2HmH/eW3aVLHcr1hK13Yl4ciuiK6Iz09GJApu
         aEPx1EIbh30G9FrsUWShaEvM2grKMq2+xqe9xSeTSEoihQ505Pc0AiMZNmad1/8zqe+D
         LXMOFcQeFT2E1irTZXmKnl3QpzqNGwSmi8Gd0KJjfixCLx2d5TDmEXhhaMGWHS+WDcdV
         Wb6Q==
X-Gm-Message-State: AOAM533M/jLu6dkLJqLGnr/hQhGQ+weIdMOiaGYHLy7IwFqAHrN8WMQs
        Ar/P8BR4V3lM3p9dFfRttKBNaA==
X-Google-Smtp-Source: ABdhPJzrzruCL6VeeZwq5YsFvJWqAM8TXVJ3XRvp97kLJM99sybRe+Gw+FFx8J8h7fW5UNTBuQyn+A==
X-Received: by 2002:a17:90a:4a09:: with SMTP id e9mr1289939pjh.36.1644597930604;
        Fri, 11 Feb 2022 08:45:30 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x1sm28587057pfh.167.2022.02.11.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:45:29 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:45:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com
Subject: Re: [PATCH 2/3] KVM: SVM: set IRR in svm_deliver_interrupt
Message-ID: <YgaSpuhhJsQKLvfP@google.com>
References: <20220211110117.2764381-1-pbonzini@redhat.com>
 <20220211110117.2764381-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211110117.2764381-3-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022, Paolo Bonzini wrote:
> SVM has to set IRR for both the AVIC and the software-LAPIC case,
> so pull it up to the common function that handles both configurations.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
