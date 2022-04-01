Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EBE4EFD52
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353456AbiDAX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiDAX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:58:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061D155228
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:56:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s8so3958591pfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=VQ+/LXmZBpLsFWJ/iYBd7+wR3oEOq8NpUsezc2JIIDw=;
        b=nELgAlV6Vv2GxUEc8WOyDjluNtKh3pCKw9l+sXlrNhWtxWpRQnlCpoYKbdUTvQH9Lr
         AuOGkrI3yUsyH7dvAa75ZRAev2JfkpPm1AnVB+MJ3PvPXUybjOcbCeH7YjOe8d3fKjHQ
         bvgiZgtaVO9eMdk3nIcXnBh1XDU5Od2gdyP1m31xyY66hXq2Cf0CpRUV16BBIXoe/4xx
         TIWAKclzDrq6q8CQdHnv/ByYsF345EJzjT/NIkwH0KD8db33UVuSj8wLjArH1pImZDNB
         VhbvEsbNvko4CbsDZOkBEB6aK9jODfJvr/eQx1DfdZ2R4CctWHceZhMi2SZvHwitnn9X
         AwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=VQ+/LXmZBpLsFWJ/iYBd7+wR3oEOq8NpUsezc2JIIDw=;
        b=1XnJzz12o1nnNpcjNSHYuR5Kk1lxvBrEM0S/SDoitto/0reKXsnSF9wR9KCIWvQIwV
         +jIYd98mk6vHhbl5sl3JGj7aAtKgdctU1ix7DW8/IKe0QaU+AefCRqTu8Lv3Ydw4+MJ8
         DGuYgrgN28Y+eDn23H8PLXoS1N8WvlTGsFYAT6qPIpZTTYrwCt5LHdCDII8yXS+vyVOw
         bdBRE/aaOKBF9Jak7LhkWPEuYYsIHNRyII88HROvvx8mEtm/wT2phRRhkrAOtCmiQ2h7
         ug2soN5hhnmQgpeeMTgeDQRQJO75APiaiIjMYohCMZ3SYvCeR56Si9nF3PkZHQfRikFu
         f/Nw==
X-Gm-Message-State: AOAM531Zc3wyjGrbMNmB3S3G6Idf/xhcgMsoWQNNUDrNwrwZh/wSeQJs
        Q239PUuYzGrtzofm3UKXxsW0lg==
X-Google-Smtp-Source: ABdhPJyjW8TjDgz0OTj7QB9ER5R991hyLy8Kyoztyj4/dY+4JL34juigk8KO2prtyD4tQpPRf+hD/g==
X-Received: by 2002:a05:6a00:234f:b0:4f6:f0c0:ec68 with SMTP id j15-20020a056a00234f00b004f6f0c0ec68mr13549033pfj.14.1648857403369;
        Fri, 01 Apr 2022 16:56:43 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm4044187pfv.48.2022.04.01.16.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:56:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
In-Reply-To: <20220331220349.885126-1-jakobkoschel@gmail.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
Subject: Re: [PATCH 1/2] drbd: remove usage of list iterator variable after loop for list_for_each_entry_safe_from()
Message-Id: <164885740219.761778.5044909883791536138.b4-ty@kernel.dk>
Date:   Fri, 01 Apr 2022 17:56:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 00:03:48 +0200, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to iterate through the list [1].
> 
> Since that variable should not be used past the loop iteration, a
> separate variable is used to 'remember the current location within the
> loop'.
> 
> [...]

Applied, thanks!

[1/2] drbd: remove usage of list iterator variable after loop for list_for_each_entry_safe_from()
      commit: 901aeda62efa21f2eae937bccb71b49ae531be06
[2/2] drbd: remove check of list iterator against head past the loop body
      commit: 2651ee5ae43241831ca63d7158bb2b151a6a0e1f

Best regards,
-- 
Jens Axboe


