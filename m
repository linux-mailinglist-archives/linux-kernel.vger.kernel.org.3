Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABE51C832
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiEESrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344848AbiEESrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:47:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E7E09D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:38:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g8so4319456pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h6f3As/+m4bLMms/WwsEXoQLRmJQOoNPDdbsWBcewj4=;
        b=qQb3iVumpLhy0QGvcH68nxEtLmyc/Tgcze+Y3k9udgQ851uac+wOQyMzBlFZ/ZtJ4q
         Hn5KV3KAP+kNIqG6gQbcQrclfNSA9rhWrgGyxICwwinFdRqAucMaIHXhv6drIZUE8ul3
         c/pp+xv+9N0DPZTuicdMVSjDN+C5/Wzfg9lowRjvXOuWyLF/6RzGkhgG/tNgEjbKjKYb
         GiORfIqsmo5wMFN3nkDHXJ9RNOoIlUcQsV0oZg2hXBzdMvMxNR4ZuIRvY+usRfdFb9RY
         NQRqPVpe8LPlPHaL3PTOjlvPrff61lvT7exnWmLqb7K/otaFtJNCYWu/qBheDPgMRZOi
         i1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6f3As/+m4bLMms/WwsEXoQLRmJQOoNPDdbsWBcewj4=;
        b=baPu3ukr7bTz5jswh0JXR5CtKtGHjCirlPYJwhNBKW/kRGxB1jPlt/7EZnmXX8DziQ
         Kgc3QBzYARdcYnrzwl+lw1J1FhvN75jiLlGzZYbbAYilUhhos+EhCFSIA/Sa4dDapF4f
         3CecpmC//Bm3aDpq6JprGQfXTcKflNjKWtBCKvsgg7CFiCiVWXw2l2jYODx5aWm21R6+
         x5H8j80W+s9y7OpD6qyFFXiuKUS5iQfQkQDVTpIMj2+UVccK0yL8jr2QTXyJoaOjGCgb
         F2l6MhlhmNanezojr1tg3lXJbtnavvjKXx5hMoN8K91Ro2aMYokv1yFlRqwAxtL33qJO
         siIg==
X-Gm-Message-State: AOAM5325KALEdtkpf+FLzT+bYBuK+a0HVwWn9jZN+xeXUGyE6bDTjyly
        iV0oyXPmqZMsmiNh3Yr2ZtrZyA==
X-Google-Smtp-Source: ABdhPJx+VtpcHX0QHHvCgxGmpTR7ph4mOyzrSwp2YZH8AnXeJHKVLYUeNRBT+9CqmVRxJAORhAb6lA==
X-Received: by 2002:a63:6cc5:0:b0:3ab:7a48:af2b with SMTP id h188-20020a636cc5000000b003ab7a48af2bmr23723065pgc.302.1651775892785;
        Thu, 05 May 2022 11:38:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b7-20020aa79507000000b0050dc7628163sm1703433pfp.61.2022.05.05.11.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 11:38:12 -0700 (PDT)
Date:   Thu, 5 May 2022 18:38:08 +0000
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
Subject: Re: [PATCH v7 05/11] KVM: selftests: Read binary stat data in lib
Message-ID: <YnQZkH02I4NE407T@google.com>
References: <20220503183045.978509-1-bgardon@google.com>
 <20220503183045.978509-6-bgardon@google.com>
 <YnQSFmNArNUMs9/U@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnQSFmNArNUMs9/U@google.com>
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
> On Tue, May 03, 2022, Ben Gardon wrote:
> Eww.  I really, really hate code that asserts on a value and then returns that
> same value.  E.g. looking at just the declaration of read_stat_data() and the
> change in stats_test(), I genuinely thought this patch dropped the assert.  The
> assert in vm_get_stat() also added to the confusion (I was reviewing that patch,
> not this one).
> 
> Rather than return the number of entries read, just assert that the number of
> elements to be read is non-zero, then vm_get_stat() doesn't need to assert because
> it'll be impossible to read anything but one entry without asserting.

Ah, and __vm_get_stat() can do:

	for (i = 0; i < vm->stats_header.num_desc; ++i) {
		desc = get_stats_descriptor(vm->stats_desc, i, &vm->stats_header);

		if (strcmp(desc->name, stat_name))
			continue;

		read_stat_data(vm->stats_fd, &vm->stats_header, desc, data,
			       max_elements);
		return;
	}

	TEST_FAIL("Stat '%s' does not exist\n", stat_name);

> 
> void read_stat_data(int stats_fd, struct kvm_stats_header *header,
> 		    struct kvm_stats_desc *desc, uint64_t *data,
> 		    size_t max_elements)
> {
> 	size_t nr_elements = min_t(size_t, desc->size, max_elements);
> 	size_t size = nr_elements * sizeof(*data);
> 	ssize_t ret;
> 
> 	TEST_ASSERT(size, "No elements in stat '%s'", desc->name);
> 
> 	ret = pread(stats_fd, data, size, header->data_offset + desc->offset);
> 
> 	TEST_ASSERT(ret == size,
> 		    "pread() failed on stat '%s', wanted %lu bytes, got %ld",
> 		    desc->name, size, ret);

Related to not printing a raw EINVAL (similar to above), it might be worth special
casing the errno path, e.g.

	TEST_ASSERT(ret >= 0, "pread() failed on stat '%s', errno: %i (%s)",
		    desc->name, errno, strerror(errno));
	TEST_ASSERT(ret == size,
		    "pread() on stat '%s' read %ld bytes, wanted %lu bytes",
		    desc->name, size, ret);
