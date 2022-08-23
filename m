Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B259ECD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiHWTuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiHWTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:49:34 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0889E69D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:52:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B1D162C1EA6;
        Tue, 23 Aug 2022 18:52:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E8B1A2C1E9E;
        Tue, 23 Aug 2022 18:52:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661280775; a=rsa-sha256;
        cv=none;
        b=KGmH7iyJd2eSoXWsDJ6nC7v7FxKNWpQIrH/eoiQ+NktQda7584haboh4sQwiDu7vC05NKH
        ptPl0mMxUQi7797CtIgQ+QexVsHWh0TUEvHwc2fA7Qrwiqve9JIKnIe41jx541uaTtHPAK
        rg3AzBcCCvnJH3YDOO93FKEH+CRetKldnTjKiLPOWYiRmZmmqUFFhVr1IMB8d2wxTNM1RW
        juspih8p43LBX6D1crFrKMVtKLKW1a8tF6ZUTcGv9mMO4XkL9kgZzYo563UdpKTZSmj3Ko
        tUaFP3l10Qnj9AQeh3PY5e8MJQBMtDfFdrSDqP0gkDPmEwPrXHg5FdBQk2QDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661280775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KA64pA0DH1EGqcQRpI8y0V/oDzrbveA11q1ujgABL90=;
        b=npRN4qNmMnMaoFIxjsD757lskhnGTMxgBkzewmOc258FSrKL5a4X7O4GFYqUoBm3H+tZrC
        /LBAT9tIxbuSjsgGqxRhgZL0Oy680KkkX9kta3EXbtE2E6Tn8b34rzsDolY21i4AvnZi23
        jUx1/0v7ptkUPoWZ2lO8iEEAY9tdm96CNVAbMDrXOsSLScxCnG7ZXurNxmi2LOtW1ypDig
        X1pZc0M4k6ThXiGGS30zI7gk6bycOpORJ2uEGz5gBjPuIwXpy4xFycUvzasQEwnPnWHSwL
        acrc50ovEy/l8zVuEXpcIjHxccBtSim+eVw3o3G6NPuDbbjAMJtP7T3GpDjCbw==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-vbjzp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Minister: 078f9ac55faa30c7_1661280775428_1173728395
X-MC-Loop-Signature: 1661280775428:1852935285
X-MC-Ingress-Time: 1661280775428
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.149 (trex/6.7.1);
        Tue, 23 Aug 2022 18:52:55 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MByzB1bVSzPS;
        Tue, 23 Aug 2022 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661280774;
        bh=KA64pA0DH1EGqcQRpI8y0V/oDzrbveA11q1ujgABL90=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=VfC5TptjeaWDVe5VzQpc3XNpYHjVl8ek74FV8aRSn5jAHg/JD7eOAtwwK6IGdxolX
         e/wJ2NwW9xkn/ACZ7gmcJczVrdAjqihCOHtjRknvnNLreRGr5msbefs0Ba9wTcI+qL
         8ryJ/g4XLh136pwrTKPZZSiwEx/Q3pMTCM1C5U45fghZhlyx0Aq6wsdCZFUtv5RjL3
         pENC6WmyOwkULjXImM4txrf0najehg9VmwdlZjfza21MD4UXOBPFfyKLnF4KBP2EYi
         FHjA3/hVIWVusR88KVbaQjZi3t3kjZHJ57TiRWbISP3ghAZ0vX5EH2ecNmGx6lAJt+
         PkWm9y2JPMQAQ==
Date:   Tue, 23 Aug 2022 11:34:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 34/70] s390: remove vma linked list walks
Message-ID: <20220823183451.su3fflupt5w5nnsn@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-35-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-35-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>Use the VMA iterator instead.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
