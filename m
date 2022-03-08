Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387214D2205
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350099AbiCHTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbiCHTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:53:51 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DEC2F008
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:52:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so2473848pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+GJxf+d39qt6iXcqaU88WSLmjEEiwXwQFcgKUX2udck=;
        b=K2ZJ5oM80IEwsivF+mIyCOMFnUjkdTZeUhvZaPuCCaAznX+6UEWVgqDVEPO8Uc9UFr
         bqE+y76VujAHCxuU0xefJgUX7fGaZXGaLQzuRSsPxyyubp774ugflszdjRYjY1eDjTQ5
         jf7LYUxn5m+msYgbX9xMRJ6zBp4TejcIx80lx5JQMZiyxh4oWXfD9L3eP5Y0u2DRQT8o
         rOw00CtxOuu3qLe8upbYseBwZmci4ObK25HCjW/TWnh49hN2JONa/+AnPLWAXjS2yjHg
         CJRGOD6lb9PCiTqynhOgnVd3LUEtPjmHtnOXGvGaUriRjKBWI8+tAWavmw3csV+/TX5b
         idgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+GJxf+d39qt6iXcqaU88WSLmjEEiwXwQFcgKUX2udck=;
        b=ppiJKxyViQ0wE5teaqwkNvXCKTm+3nQo38NpAd7FFhCcjK3s7O2n/MSpkUD8sEPr0l
         FzVpL/fYXlgq9x2xE1dbyhtebzqruJGK6kQjHbPRRQ8afNauhpLPWt78RA2tAo8t8Wla
         B2QU3xwBfbS3M1eqp2h/npxdulqEDI2lIPXwRWaWod/6DbeG8mEgbHjJRDRCqaHRADhM
         DU1VBKiXnIVr+WEfSYS/urp7qBun5Bz4Hbo8LLqjD3Ky54fOZAlwzuOSh7fWRpcb1sqn
         vpgENQSDN50F8ljHqaObtGb03PU7ATN+SZUh328nVyhjQRtAhQZ9Ci3Z/Mt9JyHOMQfT
         g44w==
X-Gm-Message-State: AOAM530519BMAhlxT4gurbHQjLx2XP6PR55ASWsAYuIP6L+cwP2bPjxB
        Bvy/e1URGRa1vqpV/SjCoyb1XQ==
X-Google-Smtp-Source: ABdhPJxtm3yXSWCs360VhpTT9/lZjt5ym3fYUaEYjIvc+92rHKX8gYlg0fNfcE03LyvJk1sRgmaXJQ==
X-Received: by 2002:a17:902:c94a:b0:151:8e65:c715 with SMTP id i10-20020a170902c94a00b001518e65c715mr19217057pla.169.1646769174088;
        Tue, 08 Mar 2022 11:52:54 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f66ce6367bsm22475439pfc.147.2022.03.08.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:52:53 -0800 (PST)
Date:   Tue, 8 Mar 2022 19:52:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 23/25] KVM: x86/mmu: replace direct_map with
 root_role.direct
Message-ID: <Yie0EonK6sW2gBkm@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-24-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-24-pbonzini@redhat.com>
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

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> direct_map is always equal to the direct field of the root page's role:
> 
> - for shadow paging, direct_map is true if CR0.PG=0 and root_role.direct is
> copied from cpu_mode.base.direct
> 
> - for TDP, it is always true and root_role.direct is also always true
> 
> - for shadow EPT, it is always false and root_role.direct is also always

Uber nit, s/EPT/TDP to cover shadow NPT, which at this point we are 100% sure is
indirect ;-)

> false
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Sean Christopherson <seanjc@google.com>
