Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9C4FFBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiDMQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDMQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5099E67D2B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649868717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOvsa3WST7Am7qLR4GLnQtAv1+rN/+HnxDMVccPamLA=;
        b=NcR6rLnI8/4+waUMRr8LGyPaxOf2bMyYTq0SmejrjYTRZ3rctGuUunqjCQMlaoCHZMjIco
        IDh3fA3Rf5WtHybYc+Q2BR/BC1d1RMoWAvbvzjSbMLKIosoBCgt5gG/3uOWk82KxJAoN2t
        d7gFgs+yo0+G2Z+JNMQDNYbGuLPP0Yw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-C_GwIpXSPbGcCraL8_LatA-1; Wed, 13 Apr 2022 12:51:56 -0400
X-MC-Unique: C_GwIpXSPbGcCraL8_LatA-1
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so1456397ilu.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOvsa3WST7Am7qLR4GLnQtAv1+rN/+HnxDMVccPamLA=;
        b=NGYtOf3oh1FvegncoWrqRYr8RIrGTotaVRlMriwH46BpBi9Ue43Io14fGWs4+lrp2d
         D6kc5NnhROSIWV322Feq5n443FBkYrd2A00W9cir957vXUHRVnZKeneGnryiBPLHWFmp
         qWn1zBqHwZZ3Y47Mv3h3VtLcDr/dbq58ZmusXcWCepL8Z0wIG+uV/JKiRnVniekKLEqo
         JATX5eX0XAfSWLSS9WmHnve/lx75W1NWVY5muhkVnWk/mNR+DArHyeXPZ+iPjobEm8O7
         tfi52qAVSZiKK3Op1CbTPmaaDyW4w7/0ak4i52EfSHjOqLQaXY8lvAlYERRRoc199pKP
         ksqw==
X-Gm-Message-State: AOAM5308KmjvXFlhdvaxKbzWxT4kqtAmGk/FkRJ3tc+QiDfH/n7JZfPs
        2YsGpYc7vbGIHu040iY2r+VoD38DTMLH7HkavWoJZAoWfy9EWrxTZ/Kjum4LCKRqLlhN+tKs5jy
        BjhDzayhPycIrKeH0+SE4Hut1
X-Received: by 2002:a05:6638:451b:b0:324:21d6:eaba with SMTP id bs27-20020a056638451b00b0032421d6eabamr15838398jab.179.1649868715592;
        Wed, 13 Apr 2022 09:51:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3LBP1cQ60v6fFVKbTsuoInv8HNrONhmGZW1zjafukQ3mQruDUvkUiR7OZ8199rn/2jM5MuQ==
X-Received: by 2002:a05:6638:451b:b0:324:21d6:eaba with SMTP id bs27-20020a056638451b00b0032421d6eabamr15838387jab.179.1649868715416;
        Wed, 13 Apr 2022 09:51:55 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id l15-20020a056e021aaf00b002c8028ec95esm228080ilv.87.2022.04.13.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:51:55 -0700 (PDT)
Date:   Wed, 13 Apr 2022 12:51:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH linux-next] mm/shmem: vma_needs_copy can be static
Message-ID: <Ylb/qmmwZlVnwYPe@xz-m1.local>
References: <202204140043.Tx7BIBvI-lkp@intel.com>
 <Ylb0CGeFJlc4EzLk@7ec4ff11d4ae>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ylb0CGeFJlc4EzLk@7ec4ff11d4ae>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:02:16AM +0800, kernel test robot wrote:
> mm/memory.c:1238:1: warning: symbol 'vma_needs_copy' was not declared. Should it be static?
> 
> Fixes: 729c63ce2bbd ("mm/shmem: handle uffd-wp during fork()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

