Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670FF4F9276
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiDHKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiDHKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:03:43 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8313F89
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:01:38 -0700 (PDT)
Date:   Fri, 08 Apr 2022 10:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649412095;
        bh=rusAaDnliVYRoqaWx3ZseyT0eG4DdEtRKyDQafUunhY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=tCALG0eT8UMW1BL26yI62yvZGYqUvlm4cJp6HVttJFU/Vw68LIV2BjpljM4Yk2N/m
         9UtMFeHqgbxq+W96l7dk+GGUmAYcK0bn3EcansddIBYaWYzPr+LLEEnrCaGDY+qy6w
         pHlaUS8CftUwPOTrMy7Thhm0tVPnPavcVt+CmrMIBIvuP3UVa9k3k3MmL1HiJUPo7B
         dOqYSAD8APV/Ov8RDlIWtgDmk/9hRVQZyxgzwK9I7mKsi+N5A3WOW42VePahZWg1+a
         6FVKiuDXihKa28jw/k3QxoLUiwRaQ/3KwPY0t4id0qJEudzImEtrFZ5lC1hfPeTFsj
         JOhcK2hBuHjGA==
To:     Grigory Vasilyev <h0tc0d3@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Evan Quan <evan.quan@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sean Paul <seanpaul@chromium.org>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
Message-ID: <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
In-Reply-To: <20220408092803.3188-1-h0tc0d3@gmail.com>
References: <20220408092803.3188-1-h0tc0d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_surfac=
e?
If not, there's no point in adding NULL checks.
