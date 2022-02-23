Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268DE4C1985
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiBWRIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbiBWRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:08:50 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DE522FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:08:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso821741pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zi4EnN7ih96Y78DZXrAg5WAm2kO2lfra+9ZshT6rCXI=;
        b=CAnMlEmBbOp4+ZwouZ9vZMfy61RYcdTKkKGRKibf2mJJKX4FI5jWKlgmGAuzB7Hnw4
         lnM+huqJ53jJvaqn8CAbdJkYq+8yze5ZQY7bgp/ANaQDAGko1VIM8d4s6wBFDfQIYXn8
         3PTfWZ3LZC8FuzDQVDhqktYJKOfbi9eg1yVRD/lrYOOM3DU8SaJY0ec1PptH0vbFyP96
         9SULNqjvl2wii4milfPtE+wwWkasfw4QBcRS6LllO1yDjmQm+BC61Ic9d5NWZQQ8qEGD
         8zqFOoFijfXEW0qVYqdVDw5KH+4kMmDk6JlwVFkXtmXWg5TFLZWFGGNQJSepHGmVkJbB
         wE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zi4EnN7ih96Y78DZXrAg5WAm2kO2lfra+9ZshT6rCXI=;
        b=DQ/hzsr6mwUD5b3K+14EA7kBSu23akHRKADDzZwSUXT8zozwnAOT7SO+UZWYerasBe
         m/t/90wXmWbZZ75zYXFINS62ZIJccymvkj0COWwUq/0kLqYBku0Z4xONqNozqiUzpQ1e
         ewpKvjrsHcV8Z0qKxqI5TnHv5q+yTNTeeJ0/LCPXL/8xsjvBBlJvLQ+q1nts/sFL5Ljz
         NCv2UmnHn1WmGq8uvYgQYFlbM1tjH/11Oeln51quG27YzSEzjCn5wW1TWrmrj9hY2oMq
         5GvFalw4TS4AW/ATgb81Mx0DIDXKXjaXS9ympQI6wQUZJpvMh3rXDcStRbeo+c/w04BI
         e7ZA==
X-Gm-Message-State: AOAM533NhZBOqmMFcIFnAuhX+C3ZM44+okgO1F/La979QPLCDTdtwQ5S
        RyzDOurpH32GYC99jx6E1p0OEYUsoSuBAQ==
X-Google-Smtp-Source: ABdhPJyZ5Jft2jFXhoA6sPRAHlardR4d7xWH2w6tXHERjEHtNB1ilcLw91l7Bc40ptwqr6HrEeAiMQ==
X-Received: by 2002:a17:902:e551:b0:14d:ad02:a79b with SMTP id n17-20020a170902e55100b0014dad02a79bmr534882plf.148.1645636102033;
        Wed, 23 Feb 2022 09:08:22 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oo7sm55020pjb.33.2022.02.23.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:08:21 -0800 (PST)
Date:   Wed, 23 Feb 2022 17:08:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: Don't actually set a request when evicting vCPUs
 for GFN cache invd
Message-ID: <YhZqAd843vFhzU6m@google.com>
References: <20220223165302.3205276-1-seanjc@google.com>
 <356ec46b00073d765d3f57ac8325e8cd13bb3eac.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356ec46b00073d765d3f57ac8325e8cd13bb3eac.camel@infradead.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022, David Woodhouse wrote:
> But please could you rebase it on your other patch, which I have
> included into my xen-evtchn-kernel branch 
> https://git.infradead.org/users/dwmw2/linux.git/commitdiff/48bc5fddd6ed
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/xen-evtchn-kernel

Ya, will do.  I almost did that straightaway, but was like, "it's just a minor
conflict..."
