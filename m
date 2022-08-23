Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BD59E583
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiHWO7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbiHWO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:59:20 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38EF30D6B3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:24:32 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11d7a859b3aso5324543fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=hdi5MwCqE5byIowYTj8N8wyEJGu5qQo7Ux+azd3wEpQ=;
        b=TT4Ut5NG8wDa+UMh/lNtQc1q0LcRDM267Nhj0AVUCb8MbgGlGThl+yfzCGUR8HfEDN
         HlwvrgnhiFRCk1I5zkPWnQlsVMfp2NnqdvK0tLZBFthgTuTRo7zdyHfGzPXENoGlnDEb
         r9IDMnAkHlbf8nDoZChmONmz89m70VTMen/VRuaB7XeJ/9tZAJJqkaL1EylYKbnyY/VU
         uFlQklzNXsfONEcj/mIdwG7sd4dBps5aT/lj0P+nT7S6eM6NvPkdWU97WJ1KLk2D/38U
         8tHciUtCmu9T2gkEEBtDNggfrMF2D0bwY/aT2P50fCWPSE2b5FShLI6+4NlS1GM4+pwF
         Baqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=hdi5MwCqE5byIowYTj8N8wyEJGu5qQo7Ux+azd3wEpQ=;
        b=GdflKBFVUdKkU2SIdV4rdHbGEavt7B9l6xLFe0Wg7sWRY1AZ6ZJNWMJI6TvQqOfg/8
         k/sWoz4/BuEH09NYNUO0KCdUq+qEpdIvn+MAQwszpyDM5sKO+raeV4MBK+Ytm/zY+cqL
         lLu2/6vOY+m0or9n7mCGKA2YUrJkxTVWxq/Z01B3k6Dc4Ufvpk0NEV4VmDJr+pZk20Ua
         7qgPPVatD1G6P06dJikbSs3O/wZXqlckiSjnFSTYNBlJ0XPMzKYlfGncYfxA4TGFnFx3
         nzqI4ToPLPqV3YAPbYuZtKIskPF/inLFYKWYttunJKOle8QC1+7UiUpGTewtgsUfXHwK
         FsQA==
X-Gm-Message-State: ACgBeo3ohL2JAGTewcihETc9IIs6IyOegFWIlhwDb1kjUaNgq6zVqLNR
        +4n6f4iO7obSDJ4YU2/ckLqbsnOMKQ258N50Kw==
X-Google-Smtp-Source: AA6agR4Hk+qtrYOq67QDe8RsoCMdRS3hkerYea17fieVkENuE0eMKn33HrNSgduI6GdfT9ZXhVdUCmrxWt6Iji1XOEA=
X-Received: by 2002:a05:6870:b28d:b0:10e:6805:b9c1 with SMTP id
 c13-20020a056870b28d00b0010e6805b9c1mr1265558oao.37.1661257428144; Tue, 23
 Aug 2022 05:23:48 -0700 (PDT)
MIME-Version: 1.0
From:   Tal Lossos <tallossos@gmail.com>
Date:   Tue, 23 Aug 2022 15:23:37 +0300
Message-ID: <CAO15rPn8MBD5+QX31xjFsccT_1bRSuYYm2P1cTWqTydZTkiH+g@mail.gmail.com>
Subject: [bug report] nvme: NULL pointer dereference in nvmet_setup_auth
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
There is a NULL pointer dereference in nvmet_setup_auth() introduced
in commit db1312dd95488b5e6ff362ff66fcf953a46b1821 causing a DoS.
As of v6.0-rc2, in target/auth.c:196, if there is an error with
ctrl->ctrl_key, it gets reassigned to NULL, and one line afterwards,
it gets dereferenced in the call for pr_debug():

ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
    host->dhchap_ctrl_key_hash);
if (IS_ERR(ctrl->ctrl_key)) {
    ret = PTR_ERR(ctrl->ctrl_key);
    ctrl->ctrl_key = NULL;   <--- Assigning NULL
}
pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
ctrl->ctrl_key->hash > 0 ?   <--- NULL pointer dereference
nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
(int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);

This bug occurs probably due to a missing goto statement (goto out_unlock).

Best Regards,
Tal Lossos
