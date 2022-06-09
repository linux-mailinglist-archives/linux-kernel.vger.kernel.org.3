Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2C544226
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiFIDxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFIDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:53:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1629B49D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:53:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cx11so20330854pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2koJarmzmGedHyxAL/i+lFQdd0Q5ZAFYaE5poQNe8+A=;
        b=RQ0R70N1jS16HKNC0Ol/Snkv+fFPQxMu+sR7KyTPcd0AtJQdfRDJChe//d33ePjW42
         NUwM+6AWLf4HFFg8nnACUzLphwGwod4E04VS00IvvGGhoglI/uAdn0OmVESO9k7YbA87
         WXoB0WPSZJwIZQYNTDVCrIBlg3nJFEaNR0URvRoZ6V+qEZfc2gJFc0HlrIL1W1WW+rDF
         1/Yc7ng+dbkR+XlDUC9pFMzh9gCVKqODsRZejDoKKLodOa0wkJ1V/grBLEapqp/wFCIH
         /I5BMumfmT4H9nCNsQOMZJKoI5zjOM9KkgLVSCyM7AwYZxsmplXtAzqYRAkSkI1RVqcd
         8nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2koJarmzmGedHyxAL/i+lFQdd0Q5ZAFYaE5poQNe8+A=;
        b=KAoM3Sg7AwEFVRgr3GjbL24M8j1UsjfdjgWefIwRWONB8CFf+eWsEhnSls/+Zjup90
         UxyLlMLo87tZMPIdLE/y/h6fZ+oPZNltlRxLlwnoU/yrk7OQGOW4B3QvqT4nNel4p3gl
         W3wVnmXglkbFHae6y9cmxQiZe8JJXyj72lC2PAY2nwKq1UqW7Enufx8/3vCFVoYfKueK
         58OXPwVA6+CeiYIuBNYW7/4qIhXle+Ke5wDaM6YtI9HbZ0vOHnm0C7ahoizY6iDTz8RP
         Uclt0qsM50j/I0BWnsto/SHVMl9kFZ33ZMFHvC3YSAvY+0EYtyJWYqn/PMJVEyxH7HSX
         YSpQ==
X-Gm-Message-State: AOAM531BvEa1IAlIo70tyeyAX7OExlvZluZIrL3DmkdNlNv93wR5r599
        dVPQgdnHJdAEW4RT07Mr44316w==
X-Google-Smtp-Source: ABdhPJz3/PMx3RZgt3QHHTiA/K9+ZXI01CeV4NC4DLpNFuQQZTFyqHCu1obpFa9lx3Ct5QRSUsQXvQ==
X-Received: by 2002:a17:902:e748:b0:164:1b1e:28fe with SMTP id p8-20020a170902e74800b001641b1e28femr38251973plf.116.1654746785210;
        Wed, 08 Jun 2022 20:53:05 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b001664ce47e11sm12584649pls.210.2022.06.08.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 20:53:04 -0700 (PDT)
Date:   Thu, 9 Jun 2022 11:53:00 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 16/19] hugetlb: Convert to migrate_folio
Message-ID: <YqFunLBBKbZN9uD9@FVFYT0MHHV2J>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608150249.3033815-17-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:02:46PM +0100, Matthew Wilcox (Oracle) wrote:
> This involves converting migrate_huge_page_move_mapping().  We also need a
> folio variant of hugetlb_set_page_subpool(), but that's for a later patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
