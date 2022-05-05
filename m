Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2751C5DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382580AbiEERRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378100AbiEERRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:17:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60D5D18D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:13:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q76so4084532pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9qiBMV9oYjDpCy34YRBYNCemjkgxUmGv2WmJfOj+tII=;
        b=teAdRcJ9QQBUyV8uhmvTRzjSDui6pYWv4sTBrD2KW7sbdfn7RI4mNI0y+Qauoxansk
         3EixmksFP1RpVnP8psBUNqOTW5gzHV96xuvL0+EcedXetUCwqTF5pzd0YZeeslBcbWoT
         3dqVwZ0ojb4uvxS4gJXfRg0irgSpOTF7OTgsn0yMJTWH3ojW9ZiiyfTbpQMDEr10zLpg
         j/QgQiTTWS8E7/XUWke9MkKVlWouasOBgx3vKmUQ4r5nXEo20hB7VvXW91JhzAKn6GGk
         Yl41Ma1f3zHJBM7dLuef/rcuJO6xj1zcDEBGeh6UB+5mCnxp1rchJAo2ZAD/gUOUjMJe
         wDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qiBMV9oYjDpCy34YRBYNCemjkgxUmGv2WmJfOj+tII=;
        b=zp/HS8aLprgIo8J+Q6eue37M8mDGz6SK7vteCn3Tr8GDIjwWYJgtyiNl+AqEn6ob7Z
         qxCHT+qZtjg27FnTRvdo3a3urpBdGjUTZf6c5LQAd71/L4kp+ZGMqaB2L4MPp5YV0IYV
         CVa7NZcU282A9TtszRPTe2ywcsdG58X/zGi+rmlwXgIzt1P+PPVEf97yRFfA20I2sgcm
         1VsW4S8IbTjLE7IfZYgtpHsYV6avPbfny6bQN9dCBZEket+SjgbixErhKy3+kzHRJAUE
         sB0tGAsF/utFkj1P8H6mMPzIyp3/+6Rk/Iw2LXZDf1ShH7EkeMQFELEq375VDKNbpZ3W
         UyHA==
X-Gm-Message-State: AOAM532aQfZWh/V/yPgmTUJMVrR/8s9bbys+Na4c0SNQON7kRKGXFQK5
        hBKohWOlMuL7dlJfLaL2f1OHWQ==
X-Google-Smtp-Source: ABdhPJzLjMHpBQLX6+W/hcTPmJexDtOxWKh9YHSpZCq6rITDbVoqi8tAwDHYpp4BS7t+whBi1qtGYg==
X-Received: by 2002:a63:2263:0:b0:399:561e:810b with SMTP id t35-20020a632263000000b00399561e810bmr22637735pgm.615.1651770813380;
        Thu, 05 May 2022 10:13:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a25-20020aa780d9000000b0050dc7628182sm1653006pfn.92.2022.05.05.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:13:33 -0700 (PDT)
Date:   Thu, 5 May 2022 17:13:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v7 03/11] KVM: selftests: Read binary stats desc in lib
Message-ID: <YnQFuQxIgopQf9ij@google.com>
References: <20220503183045.978509-1-bgardon@google.com>
 <20220503183045.978509-4-bgardon@google.com>
 <YnQEkVQJlhTTo6BQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnQEkVQJlhTTo6BQ@google.com>
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

On Thu, May 05, 2022, Sean Christopherson wrote:
> @@ -63,11 +63,12 @@ static void stats_test(int stats_fd)
>  			"Descriptor block is overlapped with data block");
> 
>  	/* Read kvm stats descriptors */
> -	stats_desc = read_stats_desc(stats_fd, &header);
> +	stats_desc = read_stats_descriptors(stats_fd, &header);
> 
>  	/* Sanity check for fields in descriptors */
>  	for (i = 0; i < header.num_desc; ++i) {
> -		pdesc = (void *)stats_desc + i * size_desc;
> +		pdesc = get_stats_descriptor(stats_desc, i, &header);
> +
>  		/* Check type,unit,base boundaries */
>  		TEST_ASSERT((pdesc->flags & KVM_STATS_TYPE_MASK)
>  				<= KVM_STATS_TYPE_MAX, "Unknown KVM stats type");

Drat, I missed two instances!  And more on top...

---
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 6252e3d6e964..6b5ce270b890 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -124,7 +124,7 @@ static void stats_test(int stats_fd)
 			"Data size is not correct");
 	/* Check stats offset */
 	for (i = 0; i < header.num_desc; ++i) {
-		pdesc = (void *)stats_desc + i * size_desc;
+		pdesc = get_stats_descriptor(stats_desc, i, &header);
 		TEST_ASSERT(pdesc->offset < size_data,
 			"Invalid offset (%u) for stats: %s",
 			pdesc->offset, pdesc->name);
@@ -139,7 +139,7 @@ static void stats_test(int stats_fd)
 	/* Read kvm stats data one by one */
 	size_data = 0;
 	for (i = 0; i < header.num_desc; ++i) {
-		pdesc = (void *)stats_desc + i * size_desc;
+		pdesc = get_stats_descriptor(stats_desc, i, &header);
 		ret = pread(stats_fd, stats_data,
 				pdesc->size * sizeof(*stats_data),
 				header.data_offset + size_data);

base-commit: 84185927b3e27502a70685848adffbe56a804d98
--

