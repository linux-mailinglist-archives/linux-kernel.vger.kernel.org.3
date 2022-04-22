Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF050C100
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiDVVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiDVVSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:18:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64B38AAF2;
        Fri, 22 Apr 2022 13:13:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h25so6508550wrc.13;
        Fri, 22 Apr 2022 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+utQDHmts9UPP01phPwUuY21AVZWcPb7bollwyH9Mk=;
        b=IJNFyE5jk2bGLMjfXZKstoGottY1Ii5MZIiMzWUVd1UhLlu53iiHJ3Ux4NgiXfru1a
         F7NmldnfmJPUHsQa1MiW0PyQLS8G0ByeNBf1qDkLfO5Din9W5/w5R6sebe9eSPlFNByD
         2KmzRVWIqsg1ZfpbFCE/aXmmPgLdAPMeBJ/mbUVznC7Bqhu+Zqet0NJhTjqFo5uf5QRM
         zGgkb7XhSiwkqVLbOscW5t2Rjoiy/ulogBKcZRxQkTGqYug8mZQVi4o5Bh1uyc9+KBj9
         Xj94IFfEYGLh1R9YjcrgHnEXC5FS+UlGyzVT0Vl4G09OYJsClXBe7oiPUQcPKeYyUy9Y
         SMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+utQDHmts9UPP01phPwUuY21AVZWcPb7bollwyH9Mk=;
        b=6IdEzsrsialgQkJ14dNNBgmx0XuHsIZ6YrVP/JldVNr1ymY2wgE1jxBxJRpH4zo3bn
         W+R5Lm5BMerxJkaTzNO1GgDqsOGes2s3AOVvErYof3EM5GCm0c+44H2KcpprO9ouXvSa
         UGzdTAuSywFbNTQBKi2BcO1IUOi1cGqUlXCiFcoInhYOgC1qoCE1pRDlVuUSI6Jw/EHk
         ygSS3g/+ZuYEmtSbNTaWushPsDL3UyyFaXRjv7MJvgQBPY20drJM0CGVLgFXz0sfyRs3
         wkaWtS0KRt5DTJug3reFIoZj+52n4tWl1WhovfMhSl9If+DFexmAV7WUF5+LDvbfC2zE
         wkzA==
X-Gm-Message-State: AOAM532lrzSxfGMfXWXU5bFzGb/YUz2qYmoaYtHz/7obD/9XUxYpGMbu
        1wZQa84kkLkGqnrthxV7BO8=
X-Google-Smtp-Source: ABdhPJyjcqBTW7qhlMx8HaQwl43iu5uwxc77fSl7v1wiuG0PZdzEPLENOOiyb9VCz3c5euNoqhh2LA==
X-Received: by 2002:a05:6000:1f83:b0:207:a4d8:5173 with SMTP id bw3-20020a0560001f8300b00207a4d85173mr5020266wrb.556.1650658146852;
        Fri, 22 Apr 2022 13:09:06 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm2901272wmq.35.2022.04.22.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 13:09:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] Documentation/vm: Remove "Using kmap-atomic" from highmem.rst.
Date:   Fri, 22 Apr 2022 22:09:03 +0200
Message-ID: <2370538.jE0xQCEvom@leap>
In-Reply-To: <YmL2EQhfQLMoU1WV@iweiny-desk3>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com> <20220421180200.16901-4-fmdefrancesco@gmail.com> <YmL2EQhfQLMoU1WV@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=C3=AC 22 aprile 2022 20:38:09 CEST Ira Weiny wrote:
> On Thu, Apr 21, 2022 at 08:01:59PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap_atomic() is deprecated in favor of kmap_local_page().
>=20
> I'm not sure deprecated is the right word.

OK, in v2 I won't use "deprecated". Instead I'll say something about a=20
strong preference to avoid its use. The reason why developers should avoid=
=20
kmap_atomic() are explained in 4/4 (I've copy-pasted some lines here for=20
your convenience):

+  Each call of kmap_atomic() in the kernel creates a non-preemptible=20
section
+  and disable pagefaults. This could be a source of unwanted latency, so=20
it
+  should be only used if it is absolutely required, otherwise=20
kmap_local_page()
+  should be used where it is feasible.

> And I think the fact that this
> documentation is stale is a better reason for the patch as is.
>=20
> This series should end up indicating the desire to stop growing kmap()=20
and
> kmap_atomic() call sites and that their deprecation is on the horizon. =20
I've
> not read the text in patch 4/4 yet.

I'll wait for your review of 4/4 before sending v2.

>=20
> > For
> > this reason the "Using kmap_atomic" section in highmem.rst is obsolete=
=20
and
> > unnecessary.
>=20
> A lot of the text is obsolete (and redundant) but the example code might=
=20
be
> useful.
>=20
> Why not move the example and relevant bits into the kdoc for=20
kmap_atomic()
> which is then automatically picked up via patch 2/4.

Yes, I agree with you. I'll take into account your suggestion for v2.

However, as I said above, I'll hold v2 until you have time to review 4/4=20
for the purpose to not miss any changes that you might require for that=20
patch too.

=46urthermore, while working on v2, I think that I'll extend this series wi=
th=20
one or two patch more, in order to address other issues I noticed.=20

Thanks,

=46abio=20


