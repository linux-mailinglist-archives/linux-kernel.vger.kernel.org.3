Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683275017A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359323AbiDNPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352691AbiDNPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A737939C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:02:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bg9so4983297pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lInCf2RXVE8npmwDZ5ywzUqr3+J9J75UOdSgNIfQucQ=;
        b=ESc0xkssnLIOHkhvRBwXjbYo2Vr5ZFQ6yUEkHvB7G+mAmWpWZUp+lSxv+sKqSxOVEc
         Y8tCyNyGi5DQ70bL22uaI2aoPmKa0ksCdthc7k7nPHdEsX2VcSjKC9vqQPUP+agkttcR
         0ZtQ1/c/XHR6aEciVwOzcs4imdQJjfgPOpi2bwOVzO1rVqbcelXCXxUYOo32bfvfmDoe
         DfMk12UuO7cSewKj6hzX1Svu7gt2GyFLXEu0rVxq2gO6HCowv8pxytEsjuYELBU6GUi4
         72bbDYdJEn9w+vFv3tG8pnoKYOm/9ICN3WPEKtV3UcyhTEztZCFw6iXXl+bvSNCgb6sm
         QxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lInCf2RXVE8npmwDZ5ywzUqr3+J9J75UOdSgNIfQucQ=;
        b=PKvJnkf4AcUwQCBdQnIOmF4o+KvSBywu5Y/BFbPVB8v3wOB8/qvpU40KSIMds/IHHA
         NwuEF2mTsWB9ufsMvmm/hyTkCJalQtpju8NvddZNVF61LqNeULWH5XlNcP5uy+sXHsJM
         o1o5dd9SpQvXXMK8UyHVm1ZWaSwpNth7zfshlXIYGPGG+2qmOZ41w3ZUeU2HmVe0bm9i
         3m8W5EdcSDNbPDZ6qmbq+IKozqeVBG8mINWlG3s9rldD1BvoNQL1KdjO4+tD/ilM5Jlr
         E3e8jY4yCWFBDS050FyBJyVI5IJjshC+3n00qPgF0Azr4fe4Y0sNVsBUlwmlrVnZL3JD
         afhw==
X-Gm-Message-State: AOAM5309LgMezD+vgmbAXhX2iPCLbln4DvqQYfxu00lxCb6RmxNoclCY
        /OkSOAs4DFWpIa1aMp0OGNAiFA==
X-Google-Smtp-Source: ABdhPJyLy/mivC4Rf6firn5yR6WditwvIF9BoAdRBNaA38H3pCk/k7GL4kOGa9MuTOemu5IXJDieDQ==
X-Received: by 2002:a05:6a00:1da2:b0:508:29cc:a894 with SMTP id z34-20020a056a001da200b0050829cca894mr4019844pfw.43.1649948575382;
        Thu, 14 Apr 2022 08:02:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm214588pfg.133.2022.04.14.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:02:54 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:02:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 00/22] https://www.spinics.net/lists/kvm/msg267878.html
Message-ID: <Ylg3m4qZ23wO+5oo@google.com>
References: <20220414074000.31438-1-pbonzini@redhat.com>
 <2939c0cb-8e0c-7de4-7143-2df303bbb542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2939c0cb-8e0c-7de4-7143-2df303bbb542@redhat.com>
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

On Thu, Apr 14, 2022, Paolo Bonzini wrote:
> Uh-oh, wrong subject.  Should be "KVM MMU refactoring part 2: role changes".
> 
> Supersedes: <20220221162243.683208-1-pbonzini@redhat.com>

Still Spinics huh?  I thought you were using b4 these days? :-)

KVM Forum 2019 - Reports of my Bloat Have Been Greatly Exaggerated - Paolo Bonzini, Red Hat, Inc.

KVM Forum 2022 - Reports of my Fossilization Have Been Greatly Understated - Paolo Bonzini, Red Hat, Inc.
