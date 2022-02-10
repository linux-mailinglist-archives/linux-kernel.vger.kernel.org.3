Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1F4B1618
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiBJTRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:17:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiBJTR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:17:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E682101C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:17:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x4so2698298plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VFvt2qkldnELMoC2bjs+OiTFLeMglGyEe/KOlRSrFPg=;
        b=Mt+K4f4Z5tTvcvLCiB7B1+ELRU1eV8ITrrGZIjrOIuaHkLs9oAE2PvsxEdY/HiZOdn
         rPkQYqw52SdvrFY7RF6M+QPzZzdkwrr7tyecxQDCZAjUX3fQFIDcNWYuKCXMTvtK4pJ0
         hbS3xwEIEaR13b1DQ2jk4a6roKxL88umON9aLTQULqq6sG1zM8hu/BCbDBWttAsX0oB7
         OEQK7mw0Pry/3NRpBakM8GG3on4ec1U3rpDcsudsZQz2JrXUyK0Eus9lV6st1CZDzv9R
         xz4nGiG5vAy8IeMkMyxd+9xe4kg/D86EtsbOsLiWF1jDVczztwOkcEznvGhjkH/oyqm4
         tgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=VFvt2qkldnELMoC2bjs+OiTFLeMglGyEe/KOlRSrFPg=;
        b=m/2bF15i6mtpcwGiIhaVSUv29Qi5aASKbJcwMkLlXDmFhoGA7Si2OeB5a8naZDhCBJ
         3Ec4ZPWzX7tb4hcNHX67nZ8IXD4NB6q84eGaD9VMYlpthWf1IJ1c/wWwrJgI6YKEAw4S
         5E/Zu57uAEPX0bh7G2M6HCZyx7tNDOQasXK4gKyMaSGCsZZ4qT4QUchsA/tkBwqONF5X
         Wbf2Nk9fyY8dG1RTuXl5NqChFWXChfoIT3gWgLMmy1HCKZpQQPklHgBSOeQ7SvwGeBju
         DwSVf+CyxNIPPEod7QekUf3dsuoYhLh+GEJIqpTMFICzrgyEtzBWovR65cTMwIawFm5b
         NTsQ==
X-Gm-Message-State: AOAM531UTGMzGkZWfHEB0hCPCfe1LnyYXt+Xd4hYXeYjol60WOG4qLS7
        lyVUBWiBOgbq3ujtL40AHiw=
X-Google-Smtp-Source: ABdhPJxudCrdOavU2G4udreBtQwdp50xSkFsvlI1XpG+5jHk3B1Xc+OUuY+Q761FtI4njg9rfpvB5A==
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr4345884pjb.210.1644520649489;
        Thu, 10 Feb 2022 11:17:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4c8c:3496:9911:5b66])
        by smtp.gmail.com with ESMTPSA id t9sm2891556pjg.44.2022.02.10.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:17:28 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Feb 2022 11:17:27 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: pin_user_pages supports NULL pages arguments?
Message-ID: <YgVkxwYtLov6Z5WZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 * pin_user_pages() - pin user pages in memory for use by other devices
 < snip >
 * @pages:      array that receives pointers to the pages pinned.
 *              Should be at least nr_pages long. Or NULL, if caller
 *              only intends to ensure the pages are faulted in.

pin_user_pages(,, pages = NULL, );
  gup_flags |= FOLL_PIN
  __get_user_pages_locked
    __get_user_pages
      ..
      VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
