Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAC53DA5C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbiFEGH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiFEGHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:07:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06173DFBA;
        Sat,  4 Jun 2022 23:07:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x4so1733256pfj.10;
        Sat, 04 Jun 2022 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ntiAGYWvOui4xB3cbO1kuW43WbW64QLsxlfvqLjsP00=;
        b=UNdwgXBqNRzek8pEr5Qw32/XwVITDA54mg7Kzlts/3Dok86B2ZXU7Lqr1Wdv51FkOu
         D+DjiX7VwRrTKbDe9kWrgm/TbkjVysKd4l5D7wVPorYtHyYfdyRppXHf4MZfzJ7QRI0G
         EC3BWN8KlO2/z7rWQ5i+BIzMbh+leiVDSOc8qAYViWptCWWG4Owq+H4XBnLjjs1xCcOz
         A8JCjb5m0d0MotydVY6eHW9GrrnezCP2hIrGtTB7iBJQaS8HSmbaubLLvbOEwEFd1AwU
         Y4nKLkkmEYL9atMXbUbAZFFBIXckKQRQLkBUUHtnrU17dM/sv/B9E0r1k5EpKBBHQfIF
         cZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ntiAGYWvOui4xB3cbO1kuW43WbW64QLsxlfvqLjsP00=;
        b=FPjopPBEwcNXp5tiVLVjPwNNf0ALmrHpzHfc5VoUya5EdFX8AqomJshz+m7f8fMlhC
         eHb+C5iBTfvd2q1vvnfqsc14Us9lf/zKN5vy/aRgLHyLMkGgD5+2DYb9dOf6l6+jSFD1
         RJoRwskJOkUOfXVysw+V16Pkqt2caV/a/RBmfRa6YUb36FAnvokDKvJVtoFLr7xp5NYn
         oQ9OBg/JWx1rQcxc1XSfDY94bnZxjep2HmFsK30ZAD5F3nzfyPTldK5H/m5dRc4P+sx7
         O9cpANjEHYV6pAymQ+0mmunDKH9JXVRDnyP5wHbAw35lFEWQWBKf64X8ozCZcFapL6jM
         hGww==
X-Gm-Message-State: AOAM530GA5DbATD8OuTM3mKdZTGx0cW+Phs0+rmWoLXAVRpSwKungFoj
        B4dsUCBlJPgUvGbInuWKnhu37MJNI0pLFA==
X-Google-Smtp-Source: ABdhPJyA1lhiKwlzudDECY/g6A/17Ban2AXmzmlCM0DNLWnaso1OtO7XN2+wdSLdJ6SJvCSQi3abLQ==
X-Received: by 2002:a05:6a00:1594:b0:51b:f4ec:4c02 with SMTP id u20-20020a056a00159400b0051bf4ec4c02mr5896399pfk.27.1654409235449;
        Sat, 04 Jun 2022 23:07:15 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709026e0100b0015e8d4eb231sm8153260plk.123.2022.06.04.23.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 23:07:14 -0700 (PDT)
Date:   Sun, 5 Jun 2022 15:07:12 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        openrisc@lists.librecores.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <YpxIENWD3gOkFiG2@antec>
References: <20220603101411.488970-1-anshuman.khandual@arm.com>
 <20220603101411.488970-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603101411.488970-7-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:44:11PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: openrisc@lists.librecores.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Is it possible to retract my Acked-by?  I was following the discussion of this
new function actually being sub optimal.  So as far as I am concerned all these
architecture patches should be nak'ed.

-Stafford
