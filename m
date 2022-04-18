Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87689505D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbiDRRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344019AbiDRRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:04:18 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4423164
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:01:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4E6722A0CCC;
        Mon, 18 Apr 2022 17:01:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A17CB2A15AA;
        Mon, 18 Apr 2022 17:01:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650301296; a=rsa-sha256;
        cv=none;
        b=MnmISJSsA6xUeBnl0dm2welPM/nKBAfU+s6vkRJQs1BhIPbeM21aM0kgXSIFxy6gTF20M+
        m+PgNbBGRwcBW3U3ngcO55r/LlYibHeww574bAiUiBmqJpK1MiayXL+y5wSHGBJC9rQj/r
        WlPLgtNEeDNnt/j/IkE9qr4hf4T3gOvAk8sruoLOkr+s/UXYAUXaOY8tb39UWYz5+Zg9De
        EIX0aJLFJ/qBy6MJuu9Z+unbxHE3QJ4B/R6XEnObf/sOO9mnd5EnFdBzP304h9Hi43GxY7
        PDE2D5B9RoRjVoiDKc0T/oWW31AMzdBYhQe5ksir5SRcODHkNf4N5DAWTQh7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650301296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6Hrl/+4hR93SGUHE8QsVTaiTer+74s/hUoZuPmuRQDk=;
        b=QVSM/BIw5eyoyD0CdjFGsFOUkuL0yRGIXevoiW+VaYktxG0cni0prbN7xxyPT+jzLS9P5W
        MCtp52kY9mw6J2PKlKVYotITs36VXp0IA9Aq408sARh1y2SUbNpxdxqmSBfaF4enijCzEs
        /HMFQBfEEE0W+mk6Rl7/IkcfQf0LxBT9xq3VK4voYkWF0Dy3eX5TVC2LpUW8JCpnWbu5iU
        3xJ32dDqQ/mNLrnc2QGwADTvXIYIbvfyoRf67CLSmVyZ6pP1oF7vEIAVhfgihtN1YpDISh
        G12gX73a740DlF87sUqnWjPn9aep4n4QMIK68gyaEoUobCHtf8cSwNPTFtj9og==
ARC-Authentication-Results: i=1;
        rspamd-5fd5798557-m85r5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.255.147 (trex/6.7.1);
        Mon, 18 Apr 2022 17:01:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Lyrical: 2a555fcb432a42ed_1650301297110_3687643367
X-MC-Loop-Signature: 1650301297110:1051821728
X-MC-Ingress-Time: 1650301297110
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KhtWL2ZNXz2T;
        Mon, 18 Apr 2022 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650301295;
        bh=6Hrl/+4hR93SGUHE8QsVTaiTer+74s/hUoZuPmuRQDk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=C8sA4bFo0qym75Cz+6bH5GUfp8nxvarA51wsXKmfNdd4bUn63iDIoh6PwFG+uRRqM
         3DMWAn2+3MewYnjpgp/kFqwxSqbOc3hlo+sHki+i9F6KRUOJ/gy0+gO29Kf4yfHWEQ
         cnz2PqoOFkLIJ+c72E61+kt1qgrNA7tao8FkidKlGlb8S3PLbx4X4JkEnNRaY/xLsE
         1HvtVUU8SbRSQmiFuw6upc6ISG+2gvRXZBHiYwOM1+3RDSBjSIytO3qGxErrPz1vVr
         8gDa21x0ZHBPQvVGQ+12glGvaxNlSWeq+Ldx5lNbJ+nNRIbPnSwLF2BrsixO78LzNP
         w+n3Fr3nZ70fw==
Date:   Mon, 18 Apr 2022 10:01:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mm/migrate: export whether or not node is toptier in
 sysf
Message-ID: <20220418170130.cjdjuvwpuf2y3otj@offworld>
Mail-Followup-To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220417034932.jborenmvfbqrfhlj@offworld>
 <c1475d8e-3ad6-cdab-5cc9-b44fef998636@intel.com>
 <20220418164503.jfips3aiwhnlfjrq@offworld>
 <9961bda1-687a-a681-743e-7eb7b9f6f751@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9961bda1-687a-a681-743e-7eb7b9f6f751@intel.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022, Dave Hansen wrote:

>I think we should try to stick to cold, hard facts as must as possible
>rather than trying to have the *kernel* dictate as a policy what is fast
>versus slow.

That's a very good point and I agree.

Thanks,
Davidlohr
